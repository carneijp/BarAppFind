//
//  CustomTabBarView.swift
//  Onde
//
//  Created by Guilherme Borges Cavali on 07/07/23.
//

import SwiftUI

struct AppTabBarView: View {
    
    @EnvironmentObject var cloud: CloudKitCRUD
    @State private var tabSelection: TabBarItems = .menu
    
    var body: some View {
        
        NavigationStack {
            CustomTabBarContainerView(selection: $tabSelection) {
                HomeView()
                    .tabBarItem(tabItem: .menu, tabSelection: $tabSelection)
                
                MapView()
                    .tabBarItem(tabItem: .map, tabSelection: $tabSelection)
                
                FavoritesView()
                    .tabBarItem(tabItem: .favorites, tabSelection: $tabSelection)
                
                ProfileView()
                    .tabBarItem(tabItem: .profile, tabSelection: $tabSelection)
            }
        }
    }
}

//struct AppTabBarView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        AppTabBarView()
//    }
//}
