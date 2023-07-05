//
//  InstagramComponent.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 18/05/23.
//

import SwiftUI

struct InstagramComponent: View {
    var body: some View {

        VStack {
            Image("Instagram")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 38, height: 38)
                    .padding(.all, 9)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("corInsta"), lineWidth: 2))
            
            Text("Instagram")
                .foregroundColor(Color("corInsta"))
                .font(.system(size:12))
        }
//        .border(Color.black, width: 3, cornerRadius: 10)
        
    }
}

struct InstagramComponent_Previews: PreviewProvider {
    static var previews: some View {
        InstagramComponent()
    }
}
