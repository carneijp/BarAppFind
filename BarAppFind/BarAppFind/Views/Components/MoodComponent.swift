//
//  MoodComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 04/05/23.
//

import SwiftUI

struct MoodComponent: View {
    var moodImage: String
    var moodName: String
    
    var body: some View {
        VStack {
            Image(moodImage)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 80)
//                .padding(.bottom, 13)
            
            Text(moodName)
                .font(.system(size: 14))
        }
        .frame(width: 80, height: 100)
        .padding(.top, 50)
        .padding(.bottom, 20)
        .padding(.horizontal, 21)
        .background(Color("gray6"))
        .cornerRadius(12)
        .shadow(radius: 3, x: 0, y: 2)
    }
}

struct MoodComponent_Previews: PreviewProvider {
    static var previews: some View {
        MoodComponent(moodImage: "esquenta", moodName: "familia")
    }
}
