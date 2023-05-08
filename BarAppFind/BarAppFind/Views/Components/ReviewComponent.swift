//
//  ReviewComponent.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 08/05/23.
//

import SwiftUI

struct ReviewComponent: View {
    let name: String
    let stars: Int
    let comment: String
    
    var body: some View {
        VStack{
            HStack{
                Text(name)
                    .font(.system(size: 14))
                Image(systemName: "star")
                Image(systemName: "star")
                Image(systemName: "star")
                Image(systemName: "star")
                Image(systemName: "star")
                
                
                Spacer()
            }
            .padding(.vertical, 5)
            HStack {
                Text(comment)
                    .font(.system(size: 12))
                    .padding(.bottom, 10)
                Spacer()
            }
        }
        .padding(.horizontal)
        .background(Color.gray)
        .cornerRadius(20)
    }
}

struct ReviewComponent_Previews: PreviewProvider {
    static var previews: some View {
        ReviewComponent(name: "Eduardo", stars: 3, comment: "Ameiii muito bom o lugar, recomendo! Somente tinha muito álcool no meu drink kkkk")
    }
}
