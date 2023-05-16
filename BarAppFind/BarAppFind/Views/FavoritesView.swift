//
//  FavoritesView.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 16/05/23.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var cloud: CloudKitCRUD = CloudKitCRUD()
    @State private var logado: Bool = false

    var body: some View {
        ScrollView {
            VStack {

                if let client = cloud.client {
                    ForEach(cloud.barsList.filter({ client.favorites.contains($0.name) }), id: \.self) { bar in
                        NavigationLink {
                            BarPageView(barname: bar.name)
                        } label: {
                            BarComponent(bar: bar)
                                .foregroundColor(.primary)
                                .padding(.bottom, 10)
                        }
                    }
                }else{
                    Text("sem favoritos")
                }
//                if logado == true{
//                    if let client = cloud.client?.favorites {
//                        ForEach(cloud.barsList, id: \.self) { bar in
//                            if client.contains(bar.name){
//                                NavigationLink {
//                                    BarPageView(barname: bar.name)
//                                } label: {
//                                    BarComponent(bar: bar)
//                                        .foregroundColor(.primary)
//                                        .padding(.bottom, 10)
//                                }
//                            }
//                        }
//                    }else{
//                        Text("Nada")
//                    }
//                }else{
//                    Text("nao logado")
//                }




            }
            .padding(.horizontal, 24)
            .padding(.top, 50)
        }
        //        .searchable(text: $text)
//        .onChange(of: cloud.client, perform: { newValue in
//            if cloud.client != nil{
//                logado = true
//            }
//        })
//            if cloud.client == nil {
//                a = false
//            } else {
//                a = true
//            }
        }
}


struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
