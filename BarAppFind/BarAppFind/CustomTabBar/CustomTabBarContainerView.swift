//
//  TabBarContainer.swift
//  Onde
//
//  Created by Guilherme Borges Cavali on 07/07/23.
//

import SwiftUI

struct CustomTabBarContainerView<Content:View>: View {
    
    @Binding var tabSelection: TabBarItems
    @State private var tabs: [TabBarItems] = []
    private let content: Content
    
    init(selection: Binding<TabBarItems>, @ViewBuilder content: () ->  Content) {
        self._tabSelection = selection
        self.content = content()
    }
    
    var body: some View {
        VStack {
            ZStack {
                content
                    .ignoresSafeArea()
            }
            
            CustomTabBarView(tabSelection: $tabSelection, tabItems: tabs)
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

struct CustomTabBarContainerView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItems] = [
        .menu, .map, .favorites, .profile
    ]
    
    static var previews: some View {
        CustomTabBarContainerView(selection: .constant(tabs.first!)) {
            Color.red
        }
    }
}
