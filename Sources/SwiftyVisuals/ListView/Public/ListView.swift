//
//  ListView.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 17/01/2021.
//

import SwiftUI

class ScrollState: ObservableObject {
    @Published var isScrolling = false
    @Published var target: AnyHashable? = nil {
        didSet {
            isScrolling = true
            withAnimation(Self.animation) {  proxy?.scrollTo(target) }
            withDelay(Self.duration * 3) { self.isScrolling = false }
        }
    }
    
    var proxy: ScrollViewProxy? = nil
    
    static let duration = 0.15
    static let animation = Animation.easeInOut(duration: duration)
}

let scrollViewContentTag = "ScrollViewContent"
let scrollViewContentCoordinateSpace = CoordinateSpace.named(scrollViewContentTag)

let scrollViewFrameTag = "ScrollViewFrame"
let scrollViewFrameCoordinateSpace = CoordinateSpace.named(scrollViewFrameTag)

/// A container that presents data items in single column format
public struct ListView<Content>: View where Content: View {
    private var cells: [Cell]
    
    var onDelete: ((IndexSet) -> Void)? = nil
    var onMove: ((IndexSet, Int) -> Void)? = nil
    
    var configuration = ListAppearance.Configuration()
    
    var editModeOnActivate: ((ListEditMode) -> Void)? = nil
    var editButtonConfiguration = EditModeDismissButton.Configuration()
    var deleteButtonConfiguration = DeleteButton.Configuration()
    
    var editingClipShape: AnyShape = .init(Rectangle())
    
    @Binding var contentOffset: CGFloat
    @Binding var scrollTarget: AnyHashable?
    
    @StateObject var editMode = ListEditMode()
    @StateObject var scrollState = ScrollState()
    @State private var models = [CellDisplayer.ViewModel]()
    
    
    init(cells: [Cell],
         contentOffset: Binding<CGFloat>,
         scrollTo scrollTarget: Binding<AnyHashable?>
    ) {
        self.cells = cells
        self._contentOffset = contentOffset
        self._scrollTarget = scrollTarget
    }
    
    public var body: some View {
        ScrollViewReader { scrollViewProxy in
            GeometryReader { scrolViewGeometry in
                TrackableScrollView(
                    showIndicators: configuration.showIndicators,
                    contentOffset: $contentOffset)
                {
                    VStack(alignment: configuration.alignment, spacing: appearance.spacing) {
                        ForEach(cells) { cell in
                            CellDisplayer(
                                onDrag: { onDrag(
                                    draggedViewModel: $0,
                                    scrollViewProxy: scrollViewProxy,
                                    scrollViewGeometry: scrolViewGeometry)
                                } ,
                                onDrop: cellDropped,
                                onActivate: editModeOnActivate,
                                onDelete: deleteCell,
                                configuration: cellDisplayerConfiguration,
                                models: $models)
                            {
                                cell
                            }
                            .id(cell.id)
                            .transition(configuration.cellTransition)
                        }
                    }
                    .padding(.horizontal, appearance.padding)
                    .coordinateSpace(name: scrollViewContentTag)
                }
                .overlay(EditModeDismissButton(configuration: editButtonConfiguration))
                .environmentObject(editMode)
                .onChange(of: scrollTarget) { if !scrollState.isScrolling { scrollState.target = $0 } }
                .onChange(of: contentOffset) { editMode.contentOffset = $0 }
                    // --- Debugging only!
//                    .onChange(of: editMode.modelID) { _ in
//                        models.forEach { model in
//                            print("\(model.id): \(model.frame.minY)")
//                        }
//                    }
//                    .onChange(of: scrollState.isScrolling) { print("isScrolling: \($0)") }
                    // --- Debuggin only!
            }
            .onAppear { scrollState.proxy = scrollViewProxy }
        }
    }
    
    func deleteCell(id: AnyHashable) {
        onDelete?(IndexSet(integer: cells.firstIndex { $0.id == id }! ))
    }
    
    func onDrag(
        draggedViewModel: CellDisplayer.ViewModel,
        scrollViewProxy: ScrollViewProxy,
        scrollViewGeometry: GeometryProxy)
    {
        autoscroll(
            draggedViewModel: draggedViewModel,
            scrollViewProxy: scrollViewProxy,
            scrollViewGeometry: scrollViewGeometry)
        
        withAnimation(.snappyAnimation) {
            slideCell(draggedViewModel: draggedViewModel)
        }
    }
    
    func autoscroll(
        draggedViewModel: CellDisplayer.ViewModel,
        scrollViewProxy: ScrollViewProxy,
        scrollViewGeometry: GeometryProxy)
    {
        guard draggedViewModel.isDragging && !scrollState.isScrolling,
              let cellDrag = draggedViewModel.cellDrag
        else { return }
        
        models.sort { $0.frame.midY < $1.frame.midY }
        
        let scrollViewFrame = scrollViewGeometry.frame(in: scrollViewFrameCoordinateSpace)
        let detectionHeight = scrollViewFrame.height * 0.1
        let scrollUpY = detectionHeight
        let scrollDownY = scrollViewFrame.maxY - detectionHeight
        
        let dragLocationInScrollViewFrame = cellDrag.locationInScrollViewFrame
        var target: AnyHashable? = nil
        if dragLocationInScrollViewFrame.isAbove(y: scrollUpY) {
            target = models.last { cellDrag.location.isBelow(y: $0.slidFrame.minY) }?.id
        } else if dragLocationInScrollViewFrame.isBelow(y: scrollDownY) {
            target = models.first { cellDrag.location.isAbove(y: $0.slidFrame.maxY) }?.id
        } else { // No dragging required
            return
        }
        
        scrollState.target = target
        draggedViewModel.cellDrag?.contentOffset = contentOffset
    }
    
    func slideCell(draggedViewModel: CellDisplayer.ViewModel) {
        guard let cellDrag = draggedViewModel.cellDrag else { return }
        
        let slideDistance = draggedViewModel.frame.height + configuration.editModeSpacing
        
        switch cellDrag.direction {
        case .down:
            models.forEach {
                if $0.frame.isBelow(draggedViewModel.frame) {
                    $0.slideOffset =
                        $0.slidFrame.isAbove(cellDrag.location) ? -slideDistance : 0
                } else {
                    $0.slideOffset = 0
                }
            }
        case .up:
            models.forEach {
                if $0.frame.isAbove(draggedViewModel.frame) {
                    $0.slideOffset =
                        $0.slidFrame.isBelow(cellDrag.location) ? slideDistance : 0
                } else {
                    $0.slideOffset = 0
                }
            }
        }
        
    }
    
    func cellDropped(cellDrag: CellDrag?, draggedViewModel: CellDisplayer.ViewModel) {
        guard let cellDrag = cellDrag else  { return }
        
        let cellIndex = cells.firstIndex { $0.id == draggedViewModel.id }!
        
        models.sort { $0.frame.midY < $1.frame.midY }
        var matchedID = draggedViewModel.id
        switch cellDrag.direction {
        case .down: matchedID = models.last { $0.slideOffset < 0 }?.id ?? matchedID
        case .up: matchedID = models.first { $0.slideOffset > 0 }?.id ?? matchedID
        }
        
        guard matchedID != draggedViewModel.id else { return }
        let matchedIndex = cells.firstIndex { $0.id == matchedID }!
        
        print("matched: \(matchedID)")
        
        withAnimation(.springyAnimation) {
            onMove?(
                IndexSet(integer: cellIndex),
                matchedIndex > cellIndex ? matchedIndex + 1 : matchedIndex
            )
            models.forEach { $0.slideOffset = 0 }
        }
    }
    
    var appearance: ListAppearance {
        editMode.isActive
            ? .editing(configuration: configuration)
            : .normal(configuration: configuration)
    }
    
    var cellDisplayerConfiguration: CellDisplayer.Configuration {
        .init(deleteButtonConfiguration: deleteButtonConfiguration, editingClipShape: editingClipShape)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView {
            Text("Hello, World").toCell()
            Button("Hello, World") { }.toCell()
        }
    }
}


