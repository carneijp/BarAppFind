//
//  MedalComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 11/05/23.
//

import SwiftUI

struct MedalComponent: View {
    var body: some View {
        HStack (spacing: 18) {
            Image(systemName: "medal.fill")
                .padding(.all, 8)
                .background()
                .cornerRadius(12)
            
            Text("Bonfiner de Carteirinha")
                .font(.system(size: 14))
        }
        .padding(.vertical)
        .frame(width: 150, height: 70)
        .background(Color("gray0"))
        .cornerRadius(12)
//        .shadow(color: .secondary, radius: 4)
    }
}

struct MedalComponent_Previews: PreviewProvider {
    static var previews: some View {
        MedalComponent()
    }
}
