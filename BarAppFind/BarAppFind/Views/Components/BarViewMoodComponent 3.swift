//
//  BarViewMoodComponent.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 15/05/23.
//

import SwiftUI

struct BarViewMoodComponent: View {
    var mood: String
    
    var body: some View {
        Image("")
            .resizable()
            .background(.secondary.opacity(0.5))
            .cornerRadius(12)
            .frame(width: (UIScreen.main.bounds.width - 58) / 3, height: 106)
    }
}

struct BarViewMoodComponent_Previews: PreviewProvider {
    static var previews: some View {
        BarViewMoodComponent(mood: "mood1")
    }
}
