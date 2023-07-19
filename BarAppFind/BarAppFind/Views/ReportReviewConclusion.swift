//
//  ReportReviewConclusion.swift
//  Onde
//
//  Created by Joao Paulo Carneiro on 18/07/23.
//

import Foundation
import SwiftUI

struct ReportReviewConclusion: View {
    @Environment(\.presentationMode) var presentation
    @Binding var showSheet: Bool
    var body: some View {
        VStack{
            Text("Tamo junto!")
                .padding(.vertical)
            Divider()
            Spacer()
            
            Image("Família")
                .resizable()
                .scaledToFit()
                .frame(width: 126, height: 178)
            Text("Obrigado por nos informar")
            Text("Seu feedback é muito importante para mantermos nosso app seguro.")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            Button {
                showSheet = false
                presentation.wrappedValue.dismiss()
            }label: {
                Text("OK")
            }
            
            Spacer()
        }
    }
}
