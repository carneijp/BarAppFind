//
//  Home.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//

import SwiftUI

struct HomeView: View {
    @State private var trendingIndex = 0
    @EnvironmentObject var cloud: CloudKitCRUD

    var body: some View {
        VStack(alignment: .leading) {
            Button{
                cloud.addUser(clients: Clients(email: "gbcmidias@gmail.com", firstName: "Guilherme", password: "12345", lastName: "Cavali")){
                    print("criei")
                }
            }label: {
                Text("cria")
            }
            Button{
                cloud.validateClientLogin(email: "gbcmidias@gmail.com", password: "12345") {
                    print("loguei")
                    print(cloud.$client)
                }
            }label: {
                Text("loga")
                
            }
            // Logo
            HStack {
                Spacer()
                LogoComponent()
                    .padding(.vertical, 8)
                Spacer()
            }
            
            // MARK: - ScrollView Vertical
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {

                    // MARK: - Trendings Carousel
                    VStack {
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack(spacing: 10) {
//                                ForEach(trendings.indices, id: \.self) { index in
//                                    NavigationLink {
//                                        BarPageView()
//                                    } label: {
//                                        TrendingComponent(trendingItem: trendings[index])
//                                    }
//
//                                }
//                            }
//                            .padding(.horizontal, 24)
//                        }
                        
                        TabView(selection: $trendingIndex) {
                            ForEach(trendings.indices, id: \.self) { index in
                                NavigationLink {
                                    BarPageView(barname: trendings[index])
                                        .environmentObject(cloud)
                                } label: {
                                    TrendingComponent(trendingItem: trendings[index])
                                }

                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .frame(height: 150)
                        
                        // Index Trending Carousel
                        HStack(spacing: 8) {
                            ForEach((0..<3), id: \.self) { index in
                                Circle()
                                    .fill(index == self.trendingIndex ? Color.secondary : Color.secondary.opacity(0.2))
                                    .frame(width: 8, height: 8)

                            }
                        }
                        .padding(.top, 8)
                    }

                    
                    // MARK: - Moods + Bars
                    VStack(alignment: .leading) {
                        
                        //Mood Section
                        Text("Hoje eu tô afim de...")
                            .font(.system(size: 14))
                            .padding(.top, 14)
                            .padding(.leading, 24)
                        
                        //Mood Section
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(moods, id: \.self) { mood in
                                    MoodComponent(mood: mood)
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                        
                        //Bars Section
                        VStack {
                            HStack {
                                Text("Bares próximos a mim")
                                    .font(.system(size: 14))
                                
                                Spacer()
                                
                                NavigationLink {
                                    BarListView()
                                } label: {
                                    Text("Ver todos")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("blue"))
                                }
                            }
                            .padding(.top, 14)
                            .padding(.bottom, 20)
                            
                            ForEach(cloud.barsList, id: \.self) { bar in
                                NavigationLink {
                                    BarPageView(barname: bar.name)
                                        .environmentObject(cloud)
                                } label: {
                                    BarComponent(bar: bar)
                                        .environmentObject(cloud)
                                        .foregroundColor(.primary)
                                        .padding(.bottom, 10)
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                }
                
                Spacer()
            }
        }
        .onAppear() {
            
            if cloud.barsList.count != 10 {
                cloud.fetchBars()
            }
            
        }
    }
}
    
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

