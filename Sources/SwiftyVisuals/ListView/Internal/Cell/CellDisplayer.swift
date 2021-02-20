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
struct CellDisplayer: View, Identifiable {
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
            .clipShape(appearance.clipShape)
            .contextMenu { menuItems }
            .background(borderShadow)
            .overlay(DeleteButton(configuration: configuration.deleteButtonConfiguration))
            .offset(x: 0, y: dragState.isDragging ? dragState.translation.height + dragOffset : 0)
            .offset(x: 0, y: viewModel.slideOffset)
            .scaleEffect(appearance.scale)
            .jiggleEffect(amplitude: configuration.jiggleAmplitude.radians, angle: jiggleAngle.radians)
            .zIndex(zIndex)
            .onChange(of: dragState, perform: updateZIndex)
            .onChange(of: viewModel.cellDrag) { _ in if dragState.isDragging { onDrag?(viewModel) } }
            .onChange(of: canJiggle, perform: toggleJiggleEffect)
            .animation(.springyAnimation, value: appearance)
            .animation(dragState.isActive ? nil : .springyAnimation, value: dragState)
            .onAppear { appendToModels(viewModel) }
            .onDisappear { removeFromModels(viewModel) }
            .saveBounds(in: $viewModel.frame, coordinateSpace: scrollViewContentCoordinateSpace)
            .afterTapGesture(add: canDrag ? pressToDrag : nil)
            
    }
    
    @ViewBuilder var menuItems: some View {
        if !editMode.isActive {
            if let menuItems = cell.menuItems {
                menuItems
                Divider()
            }
            Button("Edit") {
                withDelay(0.75) { // TODO: ADD SETTING/CUSTOM BUTTON FOR DELAY TIME
                    let activate = onActivate ?? { editState in editState.activate() }
                    activate(editMode)
                }
            }
        }
    }
    
    private var canDrag: Bool {
        return editMode.isActive
    }
    
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
    
    var borderShadow: some View {
        Color.white
            .clipShape(appearance.clipShape)
            .shadow(color: Color.black.opacity(0.5), radius: shadowRadius)
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
        withAnimation(.snappyAnimation) { shadowRadius = configuration.shadowRadius ?? 0 }
    }
    
    func stopCellDragging() {
        viewModel.isDragging = false
        viewModel.cellDrag = nil
        withAnimation(.snappyAnimation) { shadowRadius = 0 }
    }
    
    func toggleJiggleEffect(canJigle: Bool) {
        withAnimation( canJiggle
                        ? Configuration.Animation.jiggleOn.delay(.random(in: 0...0.3)) // Unsynched jiggling
                        : Configuration.Animation.jiggleOff)
        {
            jiggleAngle = canJiggle ? configuration.jiggleAmplitude : .zero
        }
    }
}

// MARK: - View Model
extension CellDisplayer {
    // MUST PROVIDE ID ON APPEAR, OTHERWISE ALL VIEW MODELS WILL BE EQUAL!
    class ViewModel: ObservableObject, Identifiable, Equatable {
        @Published var frame: CGRect = .zero
        @Published var slideOffset: CGFloat = 0
        
        @Published var cellDrag: CellDrag? = nil
        @Published var isDragging = false
        
        var id: AnyHashable = 0
        var slidFrame: CGRect { frame.offsetBy(dx: 0, dy: slideOffset) }
        
        static func == (lhs: CellDisplayer.ViewModel, rhs: CellDisplayer.ViewModel) -> Bool {
            lhs.id == rhs.id
        }
    }
}

// MARK: - CelllDisplayer.Configuration
extension CellDisplayer {
    struct Configuration {
        var deleteButtonConfiguration: DeleteButton.Configuration
        var editingClipShape: AnyShape
        var shadowRadius: CGFloat? = 15
        var jiggleAmplitude: Angle = .degrees(2)
        
        static let draggingScale: CGFloat = 1.075
        
        struct PressToDrag {
            static let minimumDuration: Double = 0.10
            static let maximumDistance: CGFloat = 500
            static let minimumDistance: CGFloat = 0
        }
        
        struct Animation {
            static let jiggleOn = SwiftUI.Animation.linear(duration: 0.35).repeatForever(autoreverses: false)
            static let jiggleOff = SwiftUI.Animation.easeInOut(duration: 0.10)
        }
    }
}

fileprivate extension CellDisplayer.Configuration {
    static var dummy: Self {
        .init(deleteButtonConfiguration: .init(), editingClipShape: AnyShape(Rectangle()))
    }
}

// MARK: - Appearance
extension CellDisplayer {
    enum Appearance: Equatable {
        case normal, editing(clipShape: AnyShape), dragging(clipShape: AnyShape)
        
        var scale: CGFloat {
            switch self {
            case .dragging: return Configuration.draggingScale
            default: return 1
            }
        }
        
        var clipShape: AnyShape {
            switch self {
            case .normal: return AnyShape(Rectangle())
            case .editing(let clipShape): return clipShape
            case .dragging(let clipShape): return clipShape
            }
        }
        
        static func == (lhs: CellDisplayer.Appearance, rhs: CellDisplayer.Appearance) -> Bool {
            switch (lhs, rhs) {
            case (.normal, .normal): return true
            case (.editing, .editing): return true
            case (.dragging, .dragging): return true
            default: return false
            }
        }
    }
}

struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        CellDisplayer(configuration: CellDisplayer.Configuration.dummy, models: .constant([])) {
            Examples.TextCell(viewModel: .init("Hello, World")).toCell()
        }
        .environmentObject(ListEditMode(false))
    }
}
