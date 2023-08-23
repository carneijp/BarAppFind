//
//  FavoritesView.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 16/05/23.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var cloud: Model
    @State private var isPresenting: Bool = true
    @State private var showSignIn: Bool = false
    @State private var showSignInList: Bool = false
    @State private var viewIndex: Int = 0

    var body: some View {
        VStack {
            
            if let client = cloud.client {
                
                if cloud.barsList.filter({ client.favorites.contains($0.name) }).count != 0 {
                    Text("\(cloud.barsList.filter({ client.favorites.contains($0.name) }).count) lugares na sua lista de favoritos")
                        .font(.system(size: 18))
                    ScrollView {
                        ForEach(cloud.barsList.filter({ client.favorites.contains($0.name) }), id: \.self) { bar in
                            NavigationLink {
                                BarPageView(barname: bar.name, bar: bar)
                                    .toolbarRole(.editor)
                            } label: {
                                BarComponent(bar: bar, showSignIn: $showSignIn, showSignInList: $showSignInList, viewIndex: $viewIndex)                                    .foregroundColor(.primary)
                                    .padding(.bottom, 10)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    
                } else {
                    EmptyViewFavorites()
                        .padding(.top, 51)
                }
            }
//            else{
//                ZStack {
//                    EmptyViewFavorites()
//                    LoginAlertComponent(title: "Login necessário", description: "Para ter acesso a lista de favoritos, realize login", isShow: $isPresenting)
//                }
//                .onAppear() {
//                    if cloud.client == nil {
//                        self.isPresenting = true
//                    }
//                }
//            }
            
            
            
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
