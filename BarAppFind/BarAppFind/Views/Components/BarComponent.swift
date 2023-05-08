//
//  BarComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 04/05/23.
//

import SwiftUI

struct BarComponent: View {
    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .foregroundColor(.gray)
                .padding(.all, 16)
                .background(.gray)
                .clipShape(Circle())
                        
            VStack {
                HStack {
                    Text("**Nome** • 3km")
                        .font(.system(size: 14))
                    
                    Spacer()
                }
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text("4,60 • aberto das 8h às 20h")
                        .font(.system(size: 14))
                    
                    Spacer()
                }
            }
        }
    }
}

struct BarComponent_Previews: PreviewProvider {
    static var previews: some View {
        BarComponent()
    }
}
