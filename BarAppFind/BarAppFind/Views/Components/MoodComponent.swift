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
            .padding(.all)
            .background(.black)
            .cornerRadius(12)
            .frame(width: 110, height: 80)
    }
}

struct MoodComponent_Previews: PreviewProvider {
    static var previews: some View {
        MoodComponent(mood: "mood1")
    }
}
