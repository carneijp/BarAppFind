//
//  FavoritesView.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 16/05/23.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var cloud: CloudKitCRUD
    @State private var logado: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                
                if let client = cloud.client {
                    
                    if cloud.barsList.filter({ client.favorites.contains($0.name) }).count != 0 {
                        ForEach(cloud.barsList.filter({ client.favorites.contains($0.name) }), id: \.self) { bar in
                            NavigationLink {
                                BarPageView(barname: bar.name)
                            } label: {
                                BarComponent(bar: bar)
                                    .foregroundColor(.primary)
                                    .padding(.bottom, 10)
                            }
                        }
                    } else {
                        EmptyViewFavorites()
                            .padding(.top, 51)
                    }
                }else{
                    Text("Realizar login")
                }

                
                
            }
            .padding(.horizontal, 24)
            .padding(.top, 50)
        }
    }
}


struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
