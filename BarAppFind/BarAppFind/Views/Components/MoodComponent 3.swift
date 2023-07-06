//
//  MoodComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 04/05/23.
//

import SwiftUI

struct MoodComponent: View {
    var moodName: String
    
    var body: some View {
        VStack {
            Image(moodName)
                .resizable()
                .scaledToFit()
                .frame(width: 110, height: 100)
            
            Text(moodName)
                .font(.system(size: 14))
        }
        .frame(width: 100, height: 100)
        .padding(.top, 30)
        .padding(.horizontal, 21)
        .padding(.bottom, 25)
        .background(Color("gray6"))
        .cornerRadius(12)
        .shadow(radius: 3, x: 0, y: 2)
    }
}

struct MoodComponent_Previews: PreviewProvider {
    static var previews: some View {
        MoodComponent(moodName: "Família")
    }
}
