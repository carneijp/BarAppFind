//
//  MoodComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 04/05/23.
//

import SwiftUI

struct MoodComponent: View {
    var moodName: String
    @Environment(\.dynamicTypeSize) var size
    
    var body: some View {
        VStack {
            Image(moodName)
                .resizable()
                .scaledToFit()
                .frame(width: 110, height: 100)
            
            Text(moodName)
                .font(.callout)
        }
        .frame(width: 100)
        .frame(maxHeight: 300)
        .padding(.top, 24)
        .padding(.horizontal, 21)
        .padding(.bottom, 25)
        .background(Color(.white))
        .cornerRadius(12)
        .shadow(color: Color("gray6") ,radius: 3, x: 0, y: 2)
        .onAppear{
            print(size)
        }
    }
}

struct MoodComponent_Previews: PreviewProvider {
    static var previews: some View {
        MoodComponent(moodName: "Família")
    }
}
