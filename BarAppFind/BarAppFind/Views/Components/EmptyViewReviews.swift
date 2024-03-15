//
//  EmptyViewReviews.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 15/05/23.
//

import SwiftUI

struct EmptyViewReviews: View {
    var body: some View {
        VStack(alignment: .center){
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color("gray3"))
                .frame(width: 140, height: 140)
                .padding(.bottom)
            
            Text("Sem avaliações ainda")
                .font(.title2)
                .padding(.vertical)
                .multilineTextAlignment(.center)


            Text("Coletar avaliações pode levar algum tempo, volte daqui a pouco")
                .font(.body)
                .foregroundColor(Color("gray3"))
                .multilineTextAlignment(.center)
            
        }
        .frame(width: UIScreen.main.bounds.width - 58)
    }
}

struct EmptyViewReviews_Previews: PreviewProvider {
    static var previews: some View {
        EmptyViewReviews()
    }
}
