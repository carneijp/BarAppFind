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
                Label("Menu", systemImage: "house.fill")
            }
            NavigationStack{
                MapView()
            }
            .tabItem{
                Label("Mapa", systemImage: "map.fill")
            }
            NavigationStack{
                FavoritesView()
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
        .tint(.primary)
    }
}

struct GeneralTab_Previews: PreviewProvider {
    static var previews: some View {
        GeneralTab()
    }
}
