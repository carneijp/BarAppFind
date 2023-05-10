//
//  MoodComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 04/05/23.
//

import SwiftUI

struct MoodComponent: View {
    var mood: String
    
    var body: some View {
        Image("")
            .resizable()
            .background(.secondary.opacity(0.5))
            .cornerRadius(12)
            .frame(width: (UIScreen.main.bounds.width - 58) / 3, height: 80)
    }
}

struct MoodComponent_Previews: PreviewProvider {
    static var previews: some View {
        MoodComponent(mood: "mood1")
    }
}
