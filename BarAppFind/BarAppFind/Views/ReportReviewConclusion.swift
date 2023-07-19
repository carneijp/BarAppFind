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
                .padding(.bottom, 12)
            Text("Obrigado por nos informar")
                .padding(.vertical, 8)
            Text("Seu feedback é muito importante para mantermos nosso app seguro.")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            Button {
                showSheet = false
                presentation.wrappedValue.dismiss()
            }label: {
                HStack{
                    Spacer()
                    Text("Ok")
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                    Spacer()
                }
                .background(.white)
                .cornerRadius(24)
                .shadow(color: Color("gray6") ,radius: 3, x: 0, y: 2)
            }
            .padding()
            
            Spacer()
        }
    }
}
