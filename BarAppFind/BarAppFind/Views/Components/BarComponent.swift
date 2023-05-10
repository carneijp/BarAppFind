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
            Image("trending1")
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 56, height: 56)
            
            
            HStack {
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
//                .background(.blue)
                
                Image(systemName: "heart")
                
            }
        }
    }
}

struct BarComponent_Previews: PreviewProvider {
    static var previews: some View {
        BarComponent()
    }
}
