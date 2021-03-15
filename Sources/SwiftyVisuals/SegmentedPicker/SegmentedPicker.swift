//
//  SwiftUIView.swift
//  
//
//  Created by Nuno Alves de Sousa on 08/03/2021.
//

import SwiftUI

public struct SegmentedPicker: View {
    @Namespace private var animation
    @Binding private var selection: Int
    @State private var targetSelection: Int
    @State private var frames: [CGRect]
    @GestureState private var drag: DragState = .inactive
    @State private var draggingWidth: CGFloat? = nil
    @State private var draggingXOffset: CGFloat? = nil
    
    private let items: [PickerItem]
    var configuration = Configuration()

    public init<Item: PickerItemConvertible>(
        selection: Binding<Int>,
        @PickerBuilder _ content: @escaping () -> Item)
    {
        self._selection = selection
        self._targetSelection = State(wrappedValue: selection.wrappedValue)
        self.items = content().asPickerItems()
        self._frames = State(wrappedValue: Array<CGRect>(repeating: CGRect(), count: items.count))
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            configuration.selector
                .gesture(dragGesture)
                .frame(width: draggingWidth ?? selectionWidth, height: frames[selection].size.height)
                .offset(x: draggingXOffset ?? xOffset, y: yOffset)
            
            HStack {
                ForEach(items.indices)  { index in
                    item(for: index)
                    if index < items.endIndex - 1 {
                        Spacer()
                    }
                }
            }
            .onPreferenceChange(PickerItemPreferenceKey.self) { preferences in
                preferences.forEach { frames[$0.id] = $0.frame }
            }
        }
        .coordinateSpace(name: "picker")
        
    }
    
    func item(for index: Int) -> some View {
            items[index].makeBody(isSelected: isTargetSelection(index))
                .padding(configuration.padding)
                .onTapGesture {
                    targetSelection = index
                    selection = index
                }
                .gesture(isSelected(index) ? dragGesture : nil)
                .background(PickerItemPreferenceSetter(id: index))
            
    }
    
    func isSelected(_ index: Int) -> Bool {
        index == selection
    }
    
    func isTargetSelection(_ index: Int) -> Bool {
        index == targetSelection
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .named("picker"))
            .updating($drag) { currentValue, drag, _ in
                drag = .dragging(translation: currentValue.translation,
                                 location: currentValue.location)
            }
            .onChanged { drag in
                draggingXOffset = frames[selection].minX + clampedDragWidth
                
                let newTarget = frames.firstIndex {
                    $0.midX == frames.sorted {
                        abs($0.midX - drag.location.x) < abs($1.midX - drag.location.x)}.first!.midX
                }!
                
                if newTarget != targetSelection {
                    targetSelection = newTarget
                    Haptics.impact(style: .medium)
                }
                
                withAnimation(.slowInOut) { draggingWidth = frames[targetSelection].width }
            }
            .onEnded { _ in
                draggingWidth = nil
                withAnimation(nil) { selection = targetSelection }
                withAnimation(.springy) { draggingXOffset = nil }
            }
    }
    
    var selectionWidth: CGFloat { frames[selection].width }
    
    var minDragWidth: CGFloat { -(frames[selection].minX - frames.first!.minX) }
    var maxDragWidth: CGFloat { frames.last!.maxX - frames[selection].maxX }
    var clampedDragWidth: CGFloat { drag.translation.width.clamped(to: minDragWidth...maxDragWidth) }
    
    var xOffset: CGFloat { frames[selection].minX + clampedDragWidth }
    var yOffset: CGFloat { frames[selection].minY }
}

struct PickerItemPreferenceData: Equatable {
    let id: Int
    let frame: CGRect
}

struct PickerItemPreferenceKey: PreferenceKey {
    typealias Value = [PickerItemPreferenceData]

    static var defaultValue: [PickerItemPreferenceData] = []
    
    static func reduce(
        value: inout [PickerItemPreferenceData],
        nextValue: () -> [PickerItemPreferenceData])
    {
        value.append(contentsOf: nextValue())
    }
}

struct PickerItemPreferenceSetter: View {
    let id: Int
    let coordinateSpace = CoordinateSpace.named("picker")
    
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: PickerItemPreferenceKey.self,
                            value: [PickerItemPreferenceData(id: id, frame: geometry.frame(in: coordinateSpace))])
        }
    }
}

extension SegmentedPicker {
    struct Configuration {
        var selector: AnyView = defaultSelector
        var padding: Padding = .init(horizontal: 5, vertical: 5)
        
        static let defaultSelector = Color.gray.opacity(0.25)
            .clipShape(Capsule())
            .eraseToAnyView()
    }
}

struct SegmentedPicker_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            StatefulPreview(2) { selection in
                SegmentedPicker(selection: selection.animation(.mediumInOut)) {
                    ForEach(1..<6) { index in
                        PickerItem { isSelected in
                            HStack(spacing: 0) {
                                if index % 2 == 0 {
                                    Text("Long option \(index)")
                                } else {
                                    Text("Option \(index)")
                                }
                            }
                            .foregroundColor(isSelected ? .black : .gray)
                            .font(.caption2)
                        }
                    }
                }
                .padding(5)
                .background(Color.secondarySystemBackground)
                .clipShape(Capsule())
                .padding(.horizontal, 5)
            }
            
            StatefulPreview(2) { selection in
                SegmentedPicker(selection: selection.animation(.mediumInOut)) {
                    ForEach(1..<6) { index in
                        PickerItem { isSelected in
                            Text("Option \(index)")
                                .foregroundColor(isSelected ? .black : .gray)
                                .font(.caption2)
                        }
                    }
                }
                .padding(5)
                .background(Color.secondarySystemBackground)
                .clipShape(Capsule())
                .padding(.horizontal, 5)
            }
        }
    }
}
