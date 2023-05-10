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
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width - 48, height: 150)
            .background(.gray.opacity(0.5))
            .cornerRadius(14)
    }
}

struct TrendingComponent_Previews: PreviewProvider {
    static var previews: some View {
        TrendingComponent(trendingItem: "trending1")
    }
}
