//
//  TrackableScrollView.swift
//
//  Created by Nuno Alves de Sousa on 24/09/2020.
//
import SwiftUI

/// A SwiftUI `ScrollView` that keeps track of its content offset via a `Binding` to `contentOffset`
public struct TrackableScrollView<Content>: View where Content: View {
    let axes: Axis.Set
    let showIndicators: Bool
    @Binding var contentOffset: CGFloat
    let content: Content
    
    init(
        _ axes: Axis.Set = .vertical,
        showIndicators: Bool = true,
        contentOffset: Binding<CGFloat>,
        @ViewBuilder content: () -> Content)
    {
        self.axes = axes
        self.showIndicators = showIndicators
        self._contentOffset = contentOffset
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader { outsideProxy in // ScrollView frame
            ScrollView(self.axes, showsIndicators: self.showIndicators) {
                ZStack(alignment: self.axes == .vertical ? .top : .leading) {
                    GeometryReader { insideProxy in // Content frame
                        Color.clear
                            .preference(
                                key: ScrollOffsetPreferenceKey.self,
                                value: [self.calculateContentOffset(
                                    ofInsideProxy: insideProxy,
                                    fromOusideProxy: outsideProxy)
                                ]
                            )
                    }
                    VStack { self.content }
                }
            }
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                self.contentOffset = value[0]
            }
        }
    }
    
    private func calculateContentOffset(
        ofInsideProxy insideProxy: GeometryProxy,
        fromOusideProxy outsideProxy: GeometryProxy) -> CGFloat
    {
        if axes == .vertical {
            return outsideProxy.frame(in: .global).minY - insideProxy.frame(in: .global).minY
        } else {
            return outsideProxy.frame(in: .global).minX - insideProxy.frame(in: .global).minX
        }
    }
}

/// A preference key that stores ScrollView content offset
fileprivate struct ScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = [CGFloat]
    
    static var defaultValue: [CGFloat] = [0]
    
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}

struct TrackableScrollViewPreview: View {
    @State private var contentOffset: CGFloat = 0
    
    var body: some View {
        TrackableScrollView(contentOffset: $contentOffset) {
            VStack(spacing: 25) {
                ForEach(0..<50) { _ in
                    Text("Current content offset: \(contentOffset)")
                }
            }
        }
    }
}

struct TrackableScrollView_Previews: PreviewProvider {
    static var previews: some View {
        TrackableScrollViewPreview()
    }
}
