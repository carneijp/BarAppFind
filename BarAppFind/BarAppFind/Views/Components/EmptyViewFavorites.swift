//
//  EmptyViewFavorites.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 16/05/23.
//

import SwiftUI

struct EmptyViewFavorites: View {
    var body: some View {
        VStack(alignment: .center){
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color("gray3"))
                .frame(width: 140, height: 140)
                .padding(.bottom)
            
            Text("Sem favoritos ainda")
                .font(.system(size: 20))
                .padding(.vertical)


            Text("Seus bares favoritos aparecerão aqui!")
                .font(.system(size: 14))
                .foregroundColor(Color("gray3"))
                .multilineTextAlignment(.center)
            
        }
        .frame(width: UIScreen.main.bounds.width - 58)
    }
}

struct EmptyViewFavorites_Previews: PreviewProvider {
    static var previews: some View {
        EmptyViewFavorites()
    }
}
