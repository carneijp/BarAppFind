//
//  MedalComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 11/05/23.
//

import SwiftUI

struct MedalComponent: View {
    var medalName: String
    
    var body: some View {
        if medalName == conquestMedals[0]{
            HStack (spacing: 12) {
                Image(medalName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 60, maxHeight: 60)
                    .foregroundColor(Color("gray1"))
                    .shadow(radius: 2, y: 2)
                
                Text(medalName)
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .bold()
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: 200)
            .background(LinearGradient(gradient: Gradient(colors: [Color("darkBlueGradient"), Color("softBlueGradient")]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(12)
            
        }else {
            HStack (spacing: 12) {
                Image(medalName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 60, maxHeight: 60)
                    .foregroundColor(Color("gray1"))
                    .shadow(radius: 2, y: 2)
                
                Text(medalName)
                    .font(.subheadline)
                    .bold()
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: 200)
            .background(Color("gray0"))
            .cornerRadius(12)
            
        }
    }
}

struct MedalComponent_Previews: PreviewProvider {
    static var previews: some View {
        MedalComponent(medalName: "Primeiro Acesso")
    }
}
