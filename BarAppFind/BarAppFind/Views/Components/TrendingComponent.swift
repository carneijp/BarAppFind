//
//  TrendingComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 04/05/23.
//

import SwiftUI

struct TrendingComponent: View {
    let trending: String
    
    var body: some View {
        NavigationLink {
            BarPageView()
        } label: {
            Image("")
                .resizable()
                .padding(.all)
                .frame(height: 104)
                .scaledToFit()
                .background(.gray)
                .cornerRadius(14)
        }


    }
}

struct TrendingComponent_Previews: PreviewProvider {
    static var previews: some View {
        TrendingComponent(trending: "mood1")
    }
}
