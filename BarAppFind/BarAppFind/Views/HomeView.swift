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
                Spacer()
            }
            
            // MARK: - ScrollView Vertical Principal da home
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {

                    // MARK: - Trendings Carousel
                    VStack {
                        TabView(selection: $trendingIndex) {
                            ForEach(trendings.indices, id: \.self) { index in
                                NavigationLink {
                                    BarPageView(barname: trendings[index])
                                        .environmentObject(cloud)
                                        .toolbarRole(.editor)
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
                    }

                    
                    // MARK: - Moods + Bars
                    VStack(alignment: .leading) {
                        
                        //Mood Section
                        Text("Onde é...")
                            .font(.system(size: 14))
                            .padding(.top, 8)
                            .padding(.leading, 24)
                        
                        //Mood Section
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(moodsImage.indices, id: \.self) { index in
                                    MoodComponent(moodImage: moodsImage[index], moodName: moodsName[index])
                                }
                            }
                            .padding(.horizontal, 24)
                            .padding(.bottom, 14)
                        }
                        .padding(.bottom, 14)
                        
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
                            .padding(.bottom, 20)
                            
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

