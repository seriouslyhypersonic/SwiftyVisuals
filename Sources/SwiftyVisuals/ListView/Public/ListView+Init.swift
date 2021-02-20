//
//  ListView+Init.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 18/01/2021.
//

import SwiftUI

public extension ListView {
    // MARK: - Collection of Cells
    init<Data>(
        _ cells: Data,
        contentOffset: Binding<CGFloat> = .constant(0),
        scrollTo scrollTarget: Binding<AnyHashable?> = .constant(nil)
    ) where
        Content == ForEach<Data, AnyHashable, Cell>,
        Data: RandomAccessCollection,
        Data.Element == Cell
    {
        self.init(cells: Array(cells), contentOffset: contentOffset, scrollTo: scrollTarget)
    }
    
    // MARK: - Identifiable Data
    init<Data>(
        _ data: Data,
        contentOffset: Binding<CGFloat> = .constant(0),
        scrollTo scrollTarget: Binding<AnyHashable?> = .constant(nil),
        @ViewBuilder cell: @escaping (Data.Element) -> Cell
    ) where
        Content == ForEach<Data, Data.Element.ID, Cell>,
        Data: RandomAccessCollection,
        Data.Element: Identifiable
    {
        let cells = data.map { cell($0).toCell(id: $0.id) }
        self.init(cells: cells, contentOffset: contentOffset, scrollTo: scrollTarget)
    }
    
    
    // MARK: - Hashable Data
    init<Data, ID>(
        _ data: Data,
        id: KeyPath<Data.Element, ID>,
        contentOffset: Binding<CGFloat> = .constant(0),
        scrollTo scrollTarget: Binding<AnyHashable?> = .constant(nil),
        @ViewBuilder cell: @escaping (Data.Element) -> Cell
    ) where
        Content == ForEach<Data, ID, Cell>,
        Data : RandomAccessCollection,
        ID : Hashable
    {
        let cells = data.map { cell($0) }
        self.init(cells: cells, contentOffset: contentOffset, scrollTo: scrollTarget)
    }
    
    // MARK: - Single View
    init(contentOffset: Binding<CGFloat> = .constant(0),
         scrollTo scrollTarget: Binding<AnyHashable?> = .constant(nil),
         @ViewBuilder content: @escaping () -> Content
    ) where Content == Cell
    {
        self.init(cells: [content()], contentOffset: contentOffset, scrollTo: scrollTarget)
    }
    
    // MARK: - Tuple Views
    init(contentOffset: Binding<CGFloat> = .constant(0),
         scrollTo scrollTarget: Binding<AnyHashable?> = .constant(nil),
         @ViewBuilder content: @escaping () -> Content
    ) where
        Content == TupleView<(Cell, Cell)>
    {
        let cells = [
            content().value.0,
            content().value.1
        ]
        self.init(cells: cells, contentOffset: contentOffset, scrollTo: scrollTarget)
    }
    
    init(contentOffset: Binding<CGFloat> = .constant(0),
         scrollTo scrollTarget: Binding<AnyHashable?> = .constant(nil),
         @ViewBuilder content: @escaping () -> Content
    ) where Content == TupleView<(Cell, Cell, Cell)>
    {
        let cells = [
            content().value.0,
            content().value.1,
            content().value.2
        ]
        self.init(cells: cells, contentOffset: contentOffset, scrollTo: scrollTarget)
    }
}


