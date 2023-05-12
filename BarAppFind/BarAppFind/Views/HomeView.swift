//
//  Home.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var cloud: CloudKitCRUD = CloudKitCRUD()
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                LogoComponent()
                    .padding(.top)
                Spacer()
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    TrendingComponent(trending: "trending1")
                        .padding(.top, 14)
                    
                    Text("Hoje eu tô afim de...")
                        .font(.system(size: 14))
                        .padding(.top, 14)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(moods, id: \.self) { mood in
                                MoodComponent(mood: mood)
                            }
                        }
                    }
                    
                    HStack {
                        Text("Bares próximos a mim")
                            .font(.system(size: 14))
                            .padding(.top, 14)
                        
                        Spacer()
                        
                        Text("Ver todos")
                            .font(.system(size: 14))
                            .padding(.top, 14)
                    }
                    
                    ForEach(cloud.barsList, id: \.self) { bar in
                        BarComponent()
                    }
                }
            }
            
            Spacer()
        }
        .onAppear(){
            cloud.fetchBars()
        }
        .padding(.horizontal, 24)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
