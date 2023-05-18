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
    @State var isShowing: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            // Logo
            HStack {
                Spacer()
                LogoComponent()
                    .padding(.top, 20)
                Spacer()
            }
            
            // MARK: - ScrollView Vertical Principal da home
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    
                    // MARK: - Trendings Carousel
                    VStack {
                        TabView(selection: $trendingIndex) {
                            ForEach(trendings.indices, id: \.self) { index in
                                TrendingComponent(trendingItem: trendings[index])
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .frame(height: 150)
                        .offset(y: -10)

                        // Index Trending Carousel
                        HStack(spacing: 8) {
                            ForEach((0..<3), id: \.self) { index in
                                Circle()
                                    .fill(index == self.trendingIndex ? Color.secondary : Color.secondary.opacity(0.2))
                                    .frame(width: 8, height: 8)
                                
                            }
                        }
                        .offset(y: -16)
                    }
                    
                    
                    // MARK: - Moods + Bars
                    VStack(alignment: .leading) {
                        
                        //Mood Section
                        Text("Qual o seu mood hoje?")
                            .font(.system(size: 14))
                            .padding(.leading, 24)
                        
                        //Mood Section
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(moodsImage.indices, id: \.self) { index in
                                    NavigationLink {
                                        MoodListView(moodName: moodsName[index])
                                            .toolbarRole(.editor)
                                        
                                    } label: {
                                        MoodComponent(moodImage: moodsImage[index], moodName: moodsName[index])
                                    }
                                }
                            }
                            .padding(.horizontal, 24)
                            .padding(.bottom, 8)
                        }
                        .padding(.bottom, 18)
                        
                        //Bars Section
                        VStack {
                            HStack {
                                Text("Sugestões de bares hoje")
                                    .font(.system(size: 14))
                                
                                Spacer()
                                
                                NavigationLink {
                                    BarListView()
                                        .toolbarRole(.editor)
                                } label: {
                                    Text("Ver todos")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("blue"))
                                }
                            }
//                            .padding(.top, 14)
                            .padding(.bottom, 10)

                            ForEach(cloud.barsList, id: \.self) { bar in
                                NavigationLink {
                                    BarPageView(barname: bar.name)
                                        .environmentObject(cloud)
                                        .toolbarRole(.editor)
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
            if let savedLogin = UserDefaults.standard.string(forKey: "Email"),
               let savedPassword = UserDefaults.standard.string(forKey: "Password"){
                cloud.validateClientLogin(email: savedLogin, password: savedPassword) { resultado in
                    if resultado{
                        print("loguei automatico")
                    }
                    else{
                        print("falhei no login")
                    }
                }
                print("falhei no login2")
            }else{
                print("falhei no login3")
            }
            
//            if cloud.barsList.count != 10 {
//                cloud.fetchBars()
//            }
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
