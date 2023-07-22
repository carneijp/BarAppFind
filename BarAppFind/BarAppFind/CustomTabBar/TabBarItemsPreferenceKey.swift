//
//  TabBarItemsPreferenceKey.swift
//  Onde
//
//  Created by Guilherme Borges Cavali on 07/07/23.
//

import SwiftUI
import Foundation

struct TabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [TabBarItems] = []
    
    static func reduce(value: inout [TabBarItems], nextValue: () -> [TabBarItems]) {
         value += nextValue()
    }
}

struct TabBarItemViewModifier: ViewModifier {
    let tab: TabBarItems
    @Binding var tabSelection: TabBarItems
    
    func body(content: Content) -> some View {
        content
            .opacity(tabSelection == tab ? 1.0 : 0.0)
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}

extension View {
    func tabBarItem(tabItem: TabBarItems, tabSelection: Binding<TabBarItems>) -> some View {
        modifier(TabBarItemViewModifier(tab: tabItem, tabSelection: tabSelection))
    }
}
