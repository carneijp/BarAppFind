//
//  BarMoodComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 12/05/23.
//

import SwiftUI

struct BarMoodComponent: View {
    var body: some View {
        VStack(spacing: 0) {
            Image("trending1")
                .resizable()
                .scaledToFill()
            
            VStack(alignment: .leading, spacing: 3) {
                Text("Nome")
                    .font(.system(size: 14))
                
                HStack {
                    Image(systemName: "star.fill")
                    Text("4.6")
                        .font(.system(size: 14))

                    Spacer()
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, 6)
            .padding(.bottom, 10)
            .background(.blue)
            
        }
        .frame(width: 170, height: 200)
        .cornerRadius(8)
    }
}

struct BarMoodComponent_Previews: PreviewProvider {
    static var previews: some View {
        BarMoodComponent()
    }
}
