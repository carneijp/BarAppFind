//
//  BarListView.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 10/05/23.
//

import SwiftUI

struct BarListView: View {
    @EnvironmentObject var cloud: Model
    @Binding var showSignIn: Bool
    @Binding var showSignInList: Bool
    @State private var viewIndex: Int = 1
    @State var searchText = ""
    @State var isLoading: Bool = true
    private var searchBar: [Bar] {
        if searchText.isEmpty {
            return cloud.barsList
        } else {
            return cloud.barsList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ForEach(searchBar, id: \.self) { bar in
                        NavigationLink {
                            BarPageView(barname: bar.name, bar: bar)
                                .toolbarRole(.editor)
                        } label: {
                            BarComponent(bar: bar, showSignIn: $showSignIn, showSignInList: $showSignInList, viewIndex: $viewIndex)
                                .foregroundColor(.primary)
                                .padding(.bottom, 10)
                        }
                    }
                }
                .padding(.horizontal, 24)
//                .padding(.bottom, 130)
                .padding(.top, 30)
            }
            .searchable(text: $searchText, prompt: "Digite o nome do bar") {
                ForEach(searchBar) { result in
                    Text(result.name).searchCompletion(result.name)
                }
            }

            if isLoading {
                LoadingViewModel()
            }
//
//            LoginAlertComponent(title: "Login Necessário!", description: "Para favoritar bares, realize o seu login!", isShow: $showSignInList)
        }
        .navigationTitle("Todos os Bares")
        
//        .padding(.top, 130)


        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                self.isLoading = false
            }
        }
    }
}

//struct BarListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BarListView(showSignIn: .constant(false))
//    }
//}
