//
//  MoodListView.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 16/05/23.
//

import SwiftUI

struct MoodListView: View {
    @EnvironmentObject var cloud: CloudKitCRUD
    var moodName: String
    
    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    var body: some View {
        ScrollView {
            ForEach(moodsBanner.indices, id: \.self) { index in
                if "\(moodName)2" == moodsBanner[index] {
                    Image(moodsBanner[index])
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                }
            }
            
            LazyVGrid(columns: columns, spacing: 18) {
                ForEach(cloud.barsList.filter({ $0.mood.contains(moodName) }), id: \.self) { bar in
                    NavigationLink {
                        BarPageView(barname: bar.name)
                            .toolbarRole(.editor)
                    } label: {
                        ForEach(moodsColors.indices, id: \.self) { index in
                            if "\(moodName)3" == moodsColors[index] {
                                BarMoodComponent(bar: bar, moodColor: moodsColors[index])
                                    .environmentObject(cloud)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
        }
        .navigationTitle(moodName)
    }
}

//struct MoodListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoodListView()
//    }
//}
