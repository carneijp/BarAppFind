//
//  TrendingComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 04/05/23.
//

import SwiftUI

struct TrendingComponent: View {
    var trendingItem: String
    
    var body: some View {
        Image(trendingItem)
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.main.bounds.width - 48)
            .cornerRadius(14)
    }
}

struct TrendingComponent_Previews: PreviewProvider {
    static var previews: some View {
        TrendingComponent(trendingItem: "trending1")
    }
}
