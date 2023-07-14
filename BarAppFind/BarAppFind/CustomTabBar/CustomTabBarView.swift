//
//  AppTabBarView.swift
//  Onde
//
//  Created by Guilherme Borges Cavali on 07/07/23.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var tabSelection: TabBarItems
    @Namespace var nameSpace
    
    let tabItems: [TabBarItems]
    
    var body: some View {
        tabVersion1
    }
}

// MARK: - PREVIEW
struct CustomTabBarView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItems] = [
        .menu, .map, .favorites, .profile
    ]
    
    static var previews: some View {
        VStack(spacing: 0) {
            Spacer()
            CustomTabBarView(tabSelection: .constant(.menu), tabItems: tabs)
        }
    }
}

// MARK: -

extension CustomTabBarView {
    
    @ViewBuilder
    private func tabBarItem(tabItem: TabBarItems) -> some View {
        
        VStack(spacing: 0) {
            
            if tabSelection.tabName == tabItem.tabName {
                Capsule()
                    .frame(width: UIScreen.main.bounds.width/6 ,height: 2)
                    .foregroundColor(.primary)
                    .matchedGeometryEffect(id: "SelectedTabItem", in: nameSpace)
            }
            
            else {
                Capsule()
                    .frame(width: UIScreen.main.bounds.width/6 ,height: 2)
                    .foregroundColor(.clear)
            }
            
            VStack {
                Image(systemName: tabItem.iconName)
                    .font(.system(size: 20))
                
                Text(tabItem.tabName)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
            }
            .foregroundColor(tabSelection.tabName == tabItem.tabName ? .primary : Color("tabItem"))
            .padding(.vertical, 12)
        }
        
    }
    
    private var tabVersion1: some View {
        HStack(spacing: 35) {
            ForEach(tabItems, id: \.self) { tabItem in
                tabBarItem(tabItem: tabItem)
                    .onTapGesture {
                        switchToTab(tabItem: tabItem)
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .background(.red.opacity(0.2))
    }
    
    private func switchToTab(tabItem: TabBarItems) {
        withAnimation(.easeInOut) {
            tabSelection = tabItem
        }
    }
}
