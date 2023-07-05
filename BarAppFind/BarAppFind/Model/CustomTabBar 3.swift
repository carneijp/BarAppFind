//
//  CustomTabBar.swift
//  Onde
//
//  Created by Guilherme Borges Cavali on 24/05/23.
//

import SwiftUI

enum TabIndex: Int {
    case menu = 0
    case mapa = 1
    case favoritos = 2
    case perfil = 3
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabIndex
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                HStack(spacing: 42) {
                    Button {
                        // Tab 1
                    } label: {
                        TabBarComponent(tabIcon: "house.fill", tabName: "Menu")
                    }
                    
                    Button {
                        // Tab 2
                    } label: {
                        TabBarComponent(tabIcon: "map.fill", tabName: "Mapa")
                    }
                    
                    Button {
                        // Tab 3
                    } label: {
                        TabBarComponent(tabIcon: "heart.fill", tabName: "Favoritos")

                    }
                    
                    Button {
                        // Tab 4
                    } label: {
                        TabBarComponent(tabIcon: "person.fill", tabName: "Perfil")
                    }
                }
                .frame(width: proxy.frame(in: .global).width, height: proxy.frame(in: .global).height*0.075)
            }
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.menu))
    }
}
