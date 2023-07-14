//
//  GeneralTab.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//

import SwiftUI

struct GeneralTab: View {
    @EnvironmentObject var cloud: CloudKitCRUD
    @State private var selection: Int = 0

    var body: some View {
        TabView(selection: $selection) {
            NavigationStack{
                HomeView()
            }
            .tabItem{
                Label("Menu", systemImage: "house.fill")
            }
            .tag(0)

            NavigationStack{
                MapView()
            }
            .tabItem{
                Label("Mapa", systemImage: "map.fill")
            }
            .tag(1)

            NavigationStack{
                FavoritesView()
            }
            .tabItem{
                Label("Favoritos", systemImage: "heart")
            }
            .tag(2)

            NavigationStack{
                ProfileView()
            }
            .tabItem{
                Label("Perfil", systemImage: "person.fill")
            }
            .tag(3)
        }
        .tint(.primary)
    }
}

//struct GeneralTab_Previews: PreviewProvider {
//    static var previews: some View {
//        GeneralTab()
//    }
//}
