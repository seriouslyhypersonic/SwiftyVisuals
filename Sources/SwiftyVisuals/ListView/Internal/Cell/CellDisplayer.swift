//
//  Cell.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 20/01/2021.
//

import SwiftUI

struct CellDrag: Equatable {
    /// Drag location in the ScrollView content coordinate space
    let location: CGPoint
    var locationInScrollViewFrame: CGPoint {
        location.applying(.init(translationX: 0, y: -contentOffset))
    }
    var contentOffset: CGFloat
    let direction: Direction
    
    init?(location: CGPoint?, frame: CGRect, contentOffset: CGFloat) {
        guard let location = location else { return nil }
        self.location = location
        self.contentOffset = contentOffset
        self.direction = .init(location: location, frame: frame)
    }
    
    enum Direction {
        case up, down
        
        init(location: CGPoint, frame: CGRect) {
            self = frame.isBelow(location) ? .up : .down
        }
    }
}

/// A view that manages individual `Cell`s in a `ListView`
struct CellDisplayer: View, Identifiable, ContextMenuProvider {
    @EnvironmentObject var editMode: ListEditMode
    
    @StateObject var viewModel = ViewModel()
    @GestureState private var dragState: DragState = .inactive
    @Binding var models: [ViewModel]
    @State private var zIndex: Double = 0
    @State private var shadowRadius: CGFloat = 0 // Change shadowRadius with non-springy animation
    @State private var jiggleAngle: Angle  = .zero
    
    let onActivate: ((ListEditMode) -> Void)?
    let cell: Cell
    var id: AnyHashable { cell.id }
    
    let onDrag: ((ViewModel) -> Void)?
    let onDrop: ((CellDrag?, ViewModel) -> Void)?
    
    var configuration: Configuration
    
    init(//viewModel: ViewModel,
         onDrag: ((ViewModel) -> Void)? = nil,
         onDrop: ((CellDrag?, ViewModel) -> Void)? = nil,
         onActivate: ((ListEditMode) -> Void)? = nil,
         onDelete: ((AnyHashable) -> Void)? = nil,
         configuration: Configuration,
         models: Binding<[ViewModel]>,
         @ViewBuilder _ content: @escaping () -> Cell )
    {
        self.onDrag = onDrag
        self.onDrop = onDrop
        self.onActivate = onActivate
        self.cell = content()
        
        self.configuration = configuration
        self.configuration.deleteButtonConfiguration.onDelete = { onDelete?(content().id) }
        
        self._models = models
    }
    
    var body: some View {
        cell
            .disabled(editMode.isActive)
            .clipShape(appearance.clipShape)
            .contextMenu { menuItems }
            .if(!configuration.isHeader) { view in
                view.background(editingBackground)
                    .overlay(DeleteButton(configuration: configuration.deleteButtonConfiguration))
                    .jiggleEffect(amplitude: configuration.jiggleAmplitude, angle: jiggleAngle)
            }
            .offset(x: 0, y: dragState.isDragging ? dragState.translation.height + dragOffset : 0)
            .offset(x: 0, y: viewModel.slideOffset)
            .scaleEffect(appearance.scale)
            .zIndex(zIndex)
            .onChange(of: dragState, perform: updateZIndex)
            .onChange(of: viewModel.cellDrag) { _ in if dragState.isDragging { onDrag?(viewModel) } }
            .onChange(of: canJiggle, perform: toggleJiggleEffect)
            .animation(.springy, value: dragState.isActive) // Appearance change
            .animation(dragState.isActive ? nil : .springy, value: dragState)
            .onAppear { appendToModels(viewModel) }
            .onDisappear { removeFromModels(viewModel) }
            .saveFrame(in: $viewModel.frame, coordinateSpace: scrollViewContentCoordinateSpace)
            .afterTapGesture(add: canDrag ? pressToDrag : nil)
            
    }
    
    @ViewBuilder var menuItems: some View {
        if !editMode.isActive {
            if let menuItems = cell.menuItems {
                menuItems
                Divider()
            }
            ContextMenuButton(
                label: Text("Edit"),
                image: editListIcon) {
                let activate = onActivate ?? { editState in editState.activate() }
                activate(editMode)
            }
        }
    }
    
    private var editListSymbolConfig: UIImage.SymbolConfiguration {
        .init(pointSize: 24.0, weight: .regular, scale: .medium)
    }
    
    private var editListIcon: Image {
        .init(uiImage: UIImage(
                named: "editable.vertical.list",
                in: .module,
                with: editListSymbolConfig)!.withRenderingMode(.alwaysTemplate))
    }
    
    private var canDrag: Bool { editMode.isActive && !configuration.isHeader }
    
    private var dragOffset: CGFloat {
        guard let initialContentOffset = viewModel.cellDrag?.contentOffset else { return 0 }
        return editMode.contentOffset - initialContentOffset
    }
    
    private var pressToDrag: some Gesture {
        LongPressGesture(
            minimumDuration: Configuration.PressToDrag.minimumDuration,
            maximumDistance: Configuration.PressToDrag.maximumDistance
        )
        .sequenced(
            before: DragGesture(
                minimumDistance: Configuration.PressToDrag.minimumDistance,
                coordinateSpace: scrollViewContentCoordinateSpace
            )
        )
        .updating($dragState) { value, state, _ in
            switch value {
            case .first(true): state = .pressing
            case .second(_, let drag):
                state = .dragging(translation: drag?.translation ?? .zero, location: drag?.location)
            default: state = .inactive
            }
        }
        .onChanged { state in
            switch state {
            case .second(true, let drag):
                if !viewModel.isDragging {
                    startCellDragging()
                }
                viewModel.cellDrag = CellDrag(
                    location: drag?.location ?? nil,
                    frame: viewModel.frame,
                    contentOffset: editMode.contentOffset)
            default: break
            }
        }
        .onEnded { state in
            switch state {
            case .second(true, let drag):
                onDrop?(CellDrag(
                            location: drag?.location ?? nil,
                            frame: viewModel.frame,
                            contentOffset: editMode.contentOffset)
                        , viewModel)
                stopCellDragging()
            default: stopCellDragging()
            }
        }
    }
    
    var appearance: Appearance {
        if dragState.isActive {
            return .dragging(clipShape: configuration.editingClipShape)
        } else if editMode.isActive {
            return .editing(clipShape: configuration.editingClipShape)
        } else {
            return .normal
        }
    }
    
    @ViewBuilder var editingBackground: some View {
        if editMode.isActive {
            configuration.editingBackground
                .zIndex(1.0)
                .transition(.opacity)
                .clipShape(appearance.clipShape)
                .shadow(color: Color.black.opacity(0.5), radius: shadowRadius)
        }
    }
    
    var canJiggle: Bool { editMode.isActive && !dragState.isActive }
    
    // Update the zIndex immediated to 1 when dragging and to 0 only after the cell snaps into place
    func updateZIndex(dragState: DragState) {
        dragState.isActive ? zIndex = 1 : withDelay(0.75) { zIndex = 0 }
    }
    
    func appendToModels(_ viewModel: ViewModel) {
        viewModel.id = id
        models.append(viewModel)
    }
    
    func removeFromModels(_ viewModel: ViewModel) {
        models.removeAll { $0 == viewModel }
    }
    
    func startCellDragging() {
        viewModel.isDragging = true
        withAnimation(.fastInout) { shadowRadius = configuration.shadowRadius ?? 0 }
    }
    
    func stopCellDragging() {
        viewModel.isDragging = false
        viewModel.cellDrag = nil
        withAnimation(.fastInout) { shadowRadius = 0 }
    }
    
    func toggleJiggleEffect(canJigle: Bool) {
        withAnimation( canJiggle
                        ? configuration.jiggleAnimation.on.delay(.random(in: 0...0.3)) // Unsynched jiggling
                        : configuration.jiggleAnimation.off)
        {
            jiggleAngle = canJiggle ? configuration.jiggleAmplitude : .zero
        }
    }
}

struct Cell_Previews: PreviewProvider {
    static let configuration = CellDisplayer.Configuration(
        deleteButtonConfiguration: .init(),
        editingClipShape: AnyShape(Rectangle()))
    
    static var previews: some View {
        CellDisplayer(configuration: configuration, models: .constant([])) {
            Examples.TextCell(viewModel: .init("Hello, World")).toCell()
        }
        .environmentObject(ListEditMode(false))
    }
}
