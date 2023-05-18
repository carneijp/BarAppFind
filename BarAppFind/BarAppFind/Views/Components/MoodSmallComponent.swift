//
//  MoodSmallComponent.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 17/05/23.
//

import SwiftUI

struct MoodSmallComponent: View {
    var moodName: String
    
    var body: some View {
        VStack {
            Image(moodName)
                .resizable()
                .scaledToFit()
                .padding([.top, .leading, .trailing])
//                .frame(width: 60, height: 80)
//                .padding(.bottom, 13)
            
            Text(moodName)
                .font(.system(size: 11))
                .padding(.bottom)
        }
        .frame(width: 120, height: 150)
//        .padding(.top, 50)
//        .padding(.bottom, 20)
//        .padding(.horizontal, 21)
        .background(Color("gray6"))
        .cornerRadius(12)
        .shadow(radius: 3, x: 0, y: 2)
    }
}

struct MoodSmallComponent_Previews: PreviewProvider {
    static var previews: some View {
        MoodSmallComponent(moodName: "Família")
    }
}
