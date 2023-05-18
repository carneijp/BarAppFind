//
//  FavoritesView.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 16/05/23.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var cloud: CloudKitCRUD
    @State private var isPresenting: Bool = true
    
    
    
    var body: some View {
        VStack {
            
            if let client = cloud.client {
                
                if cloud.barsList.filter({ client.favorites.contains($0.name) }).count != 0 {
                    ScrollView {
                        ForEach(cloud.barsList.filter({ client.favorites.contains($0.name) }), id: \.self) { bar in
                            NavigationLink {
                                BarPageView(barname: bar.name)
                                    .toolbarRole(.editor)
                            } label: {
                                BarComponent(bar: bar)
                                    .foregroundColor(.primary)
                                    .padding(.bottom, 10)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    
                } else {
                    EmptyViewFavorites()
                        .padding(.top, 51)
                }
            }else{
                ZStack {
                    EmptyViewFavorites()
                    LoginAlertComponent(title: "login", description: "logar", isShow: $isPresenting)
                }
                .onAppear() {
                    if cloud.client == nil {
                        self.isPresenting = true
                    }
                }
            }
            
            
            
            //            .padding(.top, 50)
        }
        .navigationBarTitle("Favoritos", displayMode: .inline)
    }
}


struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
