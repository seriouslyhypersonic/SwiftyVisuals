//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 01/03/2021.
//

import SwiftUI


/// A container for views that presents `ContextualMenu.MenuItem` menu items  in a contextual menu using the
/// `.menuDrawer(_:)` view modifier.
///
/// A `ContextualMenu` is created from an array of `ContextualMenu.MenuItems` which can be constructed with the help of the
///  `@MenuBuilder` result builder using any `MenuItemConvertible` conforming  type in its body
/// ```
/// struct Content: View {
///     @State private var isShowingMenu = false
///
///     var body: some View {
///         VStack {
///             Text(isShowingMenu
///                 ? "Press to show ContextualMenu"
///                 : "ContextualMenu deactivated"
///             )
///             .menuDrawer(isShowingMenu ? menu : nil)
///
///             Button(isShowingMenu? "Toggle ContextualMenu") {
///                 isShowingMenu.toggle
///             }
///         }
///     }
///
///     @MenuBuilder var menu: ContextualMenu {
///         MenuButton(text: "Button 1")
///         MenuGroup(label: "A group of menu items") {
///             MenuButton(text: "Button 2")
///             MenuButton(text: "Button 3")
///         }
///     }
/// }
/// ```
public struct ContextualMenu: View, MenuItemConvertible {
    @EnvironmentObject var presentationMode: PresentationMode
    let items: [MenuItem]
    
    public init(items: [MenuItem]) { self.items = items }
    public init(@MenuItemsBuilder _ builder: () -> [MenuItem]) { items = builder() }
    
    @ViewBuilder public var body: some View {
        VStack(spacing: 0) {
            ForEach(items.indices) { index in
                itemView(menuItem: items[index])
                divider(index: index, endIndex: items.endIndex)
            }
        }
        .background(Blur(style: .systemMaterial))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(maxWidth: Screen.width * 0.75)
    }
    
    func buttonView(from menuButton: MenuButton) -> some View {
        SwiftUI.Button {
            withAnimation(.mediumInOut) { presentationMode.isPresented = false }
            menuButton.action()
        } label: {
            HStack {
                Text(menuButton.text)
                Spacer()
                menuButton.symbol
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .if(menuButton.type == .destructive) { $0.foregroundColor(.red) }
        }
        .buttonStyle(ShadedButtonStyle())
    }
    
    @ViewBuilder func groupView(from menuGroup: MenuGroup) -> some View {
        if let label = menuGroup.label {
            Text(label)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.vertical, 3)
            Divider()
        }
        ForEach(menuGroup.items.indices) { index in
            switch menuGroup.items[index].item {
            case .button(let menuButton):
                buttonView(from: menuButton)
                divider(index: index, endIndex: menuGroup.items.endIndex)
            case .group: fatalError("nesting 'MenuGroup' is unsupported")
            }
        }
    }
    
    @ViewBuilder func itemView(menuItem: MenuItem) -> some View {
        switch menuItem.item {
        case .button(let menuButton): buttonView(from: menuButton)
        case .group(let label, let groupItems): groupView(from: MenuGroup(label: label, items: groupItems))
            
        }
    }
    
    @ViewBuilder func divider(index: Int, endIndex: Int) -> some View {
        if index != endIndex - 1 {
            Divider()
        }
    }
    
    public func asMenuItems() -> [MenuItem] {
        items
    }
}

struct ContextualMenu_Previews: PreviewProvider {
    @State static private var isLarge = false
    
    static var previews: some View {
        Background {
            ContextualMenu {
                MenuButton(text: "Option 1")
                MenuButton(text: "Option 2")
                
                MenuGroup(label: "Group 1") {
                    MenuButton(text: "Option 3")
                    MenuButton(text: "Option 4")
                    MenuButton(text: "Option 5")
                }
                
                MenuGroup(label: "Group 2") {
                    MenuButton(text: "Option 6")
                    MenuButton(text: "Option 7", type: .destructive)
                }
            }
        }
    }
}
