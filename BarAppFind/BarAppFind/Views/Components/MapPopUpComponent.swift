//
//  MapPopUpComponent.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 10/05/23.
//

import SwiftUI

struct MapPopUpComponent: View {
    var body: some View {
        VStack {
            Image("bakground")
                .resizable()
                .scaledToFit()
            VStack(alignment: .leading){
                HStack{
                    Text("Deusa Bar")
                        .font(.system(size: 14))
                        .bold()
                    
                    Text("•")
                    
                    Text("3km")
                        .font(.system(size: 12))
                }
                    .foregroundColor(.white)
                HStack{
                    Image(systemName: "star.fill")

                    
                    Text("4,60")
                        .font(.system(size: 14))
                    
                    Text("•")
                    
                    Text("Hoje: 8h às 20h")
                        .font(.system(size: 12))

                }
                    .foregroundColor(.white)

            }
        }
        .padding(.bottom)
        .background(Color.gray)
        .cornerRadius(15)
        .frame(width: 225, height: 185)
        
    }
}

struct MapPopUpComponent_Previews: PreviewProvider {
    static var previews: some View {
        MapPopUpComponent()
    }
}
