//
//  ConquestModalComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 12/05/23.
//

import SwiftUI

struct ConquestModalComponent: View {
    var body: some View {
        HStack(spacing: 24) {
            Image(systemName: "medal.fill")
                .padding(.all, 8)
                .background(.tertiary)
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Bonfiner de Carteirinha")
                    .font(.system(size: 16))
                    .bold()
                
                Text("Você conhece todos os bares do bairro Bom Fim! 🤩")
                    .font(.system(size: 14))
            }
        }
        .padding(.all, 32)
        .background()
        .cornerRadius(12)
        .shadow(color: .primary.opacity(0.1), radius: 5, x: 0, y: 4)
        .frame(height: 130)
//        .padding(.horizontal, 24)
    }
}

struct ConquestModalComponent_Previews: PreviewProvider {
    static var previews: some View {
        ConquestModalComponent()
    }
}
