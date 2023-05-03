//
//  GeneralTab.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//

import SwiftUI

struct GeneralTab: View {
    var body: some View {
        TabView{
            NavigationStack{
                HomeView()
            }
            .tabItem{
                Label("Home", systemImage: "house.fill")
            }
            NavigationStack{
                MapView()
            }
            .tabItem{
                Label("Map", systemImage: "map.fill")
            }
            NavigationStack{
                BucketListView()
            }
            .tabItem{
                Label("BucketList", systemImage: "list.star")
            }
            NavigationStack{
                ProfileView()
            }
            .tabItem{
                Label("Perfil", systemImage: "person.fill")
            }
        }
    }
}

struct GeneralTab_Previews: PreviewProvider {
    static var previews: some View {
        GeneralTab()
    }
}