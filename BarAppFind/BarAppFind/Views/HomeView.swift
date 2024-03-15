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
    @EnvironmentObject var cloud: Model
    @State private var showSignIn: Bool = false
    @State private var showSignInList: Bool = false
    @State private var viewIndex: Int = 0
    private let carouselTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State var noInternet: Bool = false
    
    @Environment(\.dynamicTypeSize) var size

    var body: some View {
        ZStack {
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
                                .font(.body)
                                .padding(.leading, 24)
                                .accessibilityLabel(Text("Qual o seu mood de hoje?"))
                            
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
                                        .accessibilityLabel(Text(moodsName[index]))
                                    }
                                }
                                .padding(.horizontal, 24)
                                .padding(.vertical, 8)
                            }
                            
                            //Bars Section
                            VStack {
                                if size <= .accessibility2{
                                    HStack {
                                        Text("Sugestões de onde ir hoje")
                                            .accessibilityLabel(Text("Sugestões de onde ir hoje"))
                                            .font(.body)
                                        Spacer()
                                        
                                        NavigationLink {
                                            BarListView(showSignIn: $showSignIn, showSignInList: $showSignInList)
                                                .toolbarRole(.editor)
                                        } label: {
                                            Text("Ver todos")
                                                .accessibilityLabel(Text("Ver todos"))
                                                .font(.body)
                                                .foregroundColor(Color("purple"))
                                        }
                                    }
                                    .padding(.vertical, 24)
                                } else {

                                        Text("Sugestões de onde ir hoje")
                                            .accessibilityLabel(Text("Sugestões de onde ir hoje"))
                                            .font(.body)
                                            .padding(.top, 24)
                                        //                                        .padding(.bottom, 16)


                                        NavigationLink {
                                            BarListView(showSignIn: $showSignIn, showSignInList: $showSignInList)
                                                .toolbarRole(.editor)
                                        } label: {
                                            Text("Ver todos")
                                                .accessibilityLabel(Text("Ver todos"))
                                                .font(.body)
                                                .foregroundColor(Color("purple"))
                                        }
                                        .padding(.bottom, 24)
                                    
                                }
                                
                                ForEach(cloud.barsList, id: \.self) { bar in
                                    NavigationLink {
                                        BarPageView(barname: bar.name, bar: bar)
                                            .environmentObject(cloud)
                                            .toolbarRole(.editor)
                                    } label: {
                                        BarComponent(bar: bar, showSignInList: $showSignInList, viewIndex: $viewIndex)
                                            .environmentObject(cloud)
                                            .foregroundColor(.primary)
                                            .padding(.bottom, 10)
                                    }
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                    }
                    .padding(.bottom, 20)
                    
                    Spacer()
                }
            }
            .refreshable {
                cloud.fetchBars { }
            }
            
//            LoginAlertComponent(title: "Login Necessário!", description: "Para favoritar bares, realize o seu login!", isShow: $showSignIn)
            
        }
        .onChange(of: cloud.barsList.count, perform: { newValue in
            if map.locationServicesEnabled {
                
                for i in 0..<cloud.barsList.count{
                    if cloud.barsList[i].distanceFromUser != nil {
                        
                    } else{
                        cloud.barsList[i].calculateDistance(userLocation: map.userCLlocation2d)
                    }
                }
                cloud.barsList.sort{$0.distanceFromUser ?? 100000 < $1.distanceFromUser ?? 100000
                    
                }
                
            }

        })
        .onAppear() {
//            if let user = UserDefaults.standard.string(forKey: "UserID"), user != ""{
//                cloud.validadeClientLoginWithApple(userID: user) { _ in }
//            }else{
//                if cloud.client == nil{
//                    if let savedLogin = UserDefaults.standard.string(forKey: "Email"),
//                       let savedPassword = UserDefaults.standard.string(forKey: "Password"){
//                        cloud.validateClientLogin(email: savedLogin, password: savedPassword) { _ in }
//                    }
//                }
//
//
//            }
            
            if map.locationServicesEnabled {
                for i in 0..<cloud.barsList.count{
                    if cloud.barsList[i].distanceFromUser != nil {
                        
                    } else{
                        cloud.barsList[i].calculateDistance(userLocation: map.userCLlocation2d)
                    }
                }
                cloud.barsList.sort{$0.distanceFromUser ?? 100000 < $1.distanceFromUser ?? 100000}
            }
        
        }
        .padding(.top, 20)
        
    }
}

extension HomeView {
    func getDateOfWeek() -> String {
        let index = Calendar.current.component(.weekday, from: Date()) // this returns an Int
        let weekday: String = Calendar.current.weekdaySymbols[index - 1]
        
        return weekday
    }
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
