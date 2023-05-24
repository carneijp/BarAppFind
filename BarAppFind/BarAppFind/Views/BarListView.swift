//
//  BarListView.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 10/05/23.
//

import SwiftUI

struct BarListView: View {
    @EnvironmentObject var cloud: CloudKitCRUD
    @Binding var showSignIn: Bool
    @Binding var showSignInList: Bool
    @State private var viewIndex: Int = 1
    @State var searchText = ""
    @State var isLoading: Bool = true
    
    var body: some View {

        ZStack {
            ScrollView {
                VStack {
                    ForEach(searchBar, id: \.self) { bar in
                        NavigationLink {
                            BarPageView(barname: bar.name)
                                .toolbarRole(.editor)
                        } label: {
                            BarComponent(bar: bar, showSignIn: $showSignIn, showSignInList: $showSignInList, viewIndex: $viewIndex)
                                .foregroundColor(.primary)
                                .padding(.bottom, 10)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 130)
            }
            .searchable(text: $searchText, prompt: "Nome do bar") {
                    ForEach(searchBar) { result in
                        Text(result.name).searchCompletion(result.name)
                    }
            }
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
            LoginAlertComponent(title: "Login Necessário!", description: "Para favoritar bares, realize o seu login!", isShow: $showSignInList)
        }
        .padding(.top, 130)
        .navigationTitle("Todos os Bares")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            self.isLoading = true
            cloud.fetchBars() { result in
                if result {
                    self.isLoading = false
                }
            }
        }
        
    }
    
    var searchBar: [Bar] {
        if searchText.isEmpty {
            return cloud.barsList
        } else {
            return cloud.barsList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    
    
}

//struct BarListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BarListView(showSignIn: .constant(false))
//    }
//}
