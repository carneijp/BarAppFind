//
//  GeneralTab.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//

import SwiftUI

struct GeneralTab: View {
    @EnvironmentObject var cloud: CloudKitCRUD
    var body: some View {
        TabView{
            NavigationStack{
                HomeView()
            }
            .tabItem{
                Label("Home", systemImage: "house.fill")
            }
            NavigationStack{
                MapView(mapStyle: .large)
            }
            .tabItem{
                Label("Map", systemImage: "map.fill")
            }
            NavigationStack{
                BucketListView()
            }
            .tabItem{
                Label("Favoritos", systemImage: "heart")
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
