//
//  ReviewComponent.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 08/05/23.
//

import SwiftUI

struct ReviewComponent: View {
//    let name: String
//    let stars: Int
//    let comment: String
    
    let review: Review
    
    var body: some View {
        VStack{
            HStack{
                Text(review.writerName)
                    .font(.system(size: 14))
                    .padding(.top, 5)
                Image(systemName: "star")
                Image(systemName: "star")
                Image(systemName: "star")
                Image(systemName: "star")
                Image(systemName: "star")
                
                
                Spacer()
            }
            .padding(.vertical, 5)
            HStack {
                Text(review.description)
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
        ReviewComponent(review: Review(writerEmail: "aa", writerName: "Eduardo", grade: 3, description: "muiro bom", barName: "aa"))
    }
}
