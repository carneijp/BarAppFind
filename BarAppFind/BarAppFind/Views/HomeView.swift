//
//  Home.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//

import SwiftUI

struct HomeView: View {
    @State private var trendingIndex = 0
    @EnvironmentObject var map: MapViewModel
    @EnvironmentObject var cloud: CloudKitCRUD
    @State private var showSignIn: Bool = false
    @State private var showSignInList: Bool = false
    @State private var viewIndex: Int = 0
    private let carouselTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
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
                            .onReceive(carouselTimer) { _ in
                                let newIndex = (trendingIndex + 1) % 3
                                withAnimation {
                                    trendingIndex = newIndex
                                }
                            }
                            
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
                                .font(.system(size: 16))
                                .padding(.leading, 24)
                            
                            //Mood Section
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(moodsImage.indices, id: \.self) { index in
                                        NavigationLink {
                                            MoodListView(moodName: moodsName[index])
                                                .toolbarRole(.editor)
                                            
                                        } label: {
                                            MoodComponent(moodName: moodsName[index])
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
                                    Text("Sugestões de Onde ir hoje...")
                                        .font(.system(size: 16))
                                    
                                    Spacer()
                                    
                                    NavigationLink {
                                        BarListView(showSignIn: $showSignIn, showSignInList: $showSignInList)
                                            .toolbarRole(.editor)
                                    } label: {
                                        Text("Ver todos")
                                            .font(.system(size: 16))
                                            .foregroundColor(.primary)
                                    }
                                    
                                }
                                .padding(.bottom, 16)
                                
                                ForEach(cloud.barsList, id: \.self) { bar in
                                    NavigationLink {
                                        BarPageView(barname: bar.name)
                                            .environmentObject(cloud)
                                            .toolbarRole(.editor)
                                    } label: {
                                        BarComponent(bar: bar, showSignIn: $showSignIn, showSignInList: $showSignInList, viewIndex: $viewIndex)
                                            .environmentObject(cloud)
                                            .foregroundColor(.primary)
                                            .padding(.bottom, 10)
                                    }
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                    }
                    .padding(.bottom, 100)
                    
                    Spacer()
                }
            }
            
            LoginAlertComponent(title: "Login Necessário!", description: "Para favoritar bares, realize o seu login!", isShow: $showSignIn)
            
            //            SerafiniComponent(isShow: $showSerafini)
            
        }
        .onAppear() {
            if cloud.client == nil{
                if let savedUserID = UserDefaults.standard.string(forKey: "UserID"){
                    if savedUserID != ""{
                        cloud.validadeClientLoginWithApple(userID: savedUserID) { saida in
                            if saida{
                                print("loguei automaticamente com a apple")
                            }
                        }
                    }
                }
                
                
                
                if let savedLogin = UserDefaults.standard.string(forKey: "Email"),
                   let savedPassword = UserDefaults.standard.string(forKey: "Password"){
                    if savedLogin != "" && savedPassword != ""{
                        cloud.validateClientLogin(email: savedLogin, password: savedPassword) { resultado in
                            if resultado{
                                print("loguei automatico")
                            }
                        }
                    }
                }
            }
            map.chekIfLocationService{ permission in
                if permission{
                    for i in 0..<cloud.barsList.count{
                        cloud.barsList[i].calculateDistance(userLocation: map.userCLlocation2d ?? MapDetails.initialCoordinate)
                    }
                    cloud.barsList.sort{$0.distanceFromUser < $1.distanceFromUser}
                }
            }
        }
        .padding(.top, 100)
        
    }
}

func getDateOfWeek() -> String {
    let index = Calendar.current.component(.weekday, from: Date()) // this returns an Int
    let weekday: String = Calendar.current.weekdaySymbols[index - 1]
    
    return weekday
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
