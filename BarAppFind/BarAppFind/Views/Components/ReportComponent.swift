//
//  ReportComponent.swift
//  Onde
//
//  Created by Guilherme Borges Cavali on 05/07/23.
//

import SwiftUI

struct ReportComponent: View {
    
    @EnvironmentObject private var cloud: CloudKitCRUD
    @Environment(\.presentationMode) var presentation
    
    @State var subject: String = ""
    @State var comment: String = ""
    
    var body: some View {
        VStack {
            HStack{
                Text("Reportar Problema")
                    .font(.system(size: 16))
                    .bold()
                    .padding(.leading, UIScreen.main.bounds.width/4)
                
                Spacer()
                
                Button {
                    presentation.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "x.circle")
                }
            }
            .padding(.vertical, 12)
            .background(.secondary.opacity(0.05))
            .padding(.bottom, 30)
            
            HStack{
                Text("Reportar Problema")
                    .font(.system(size: 18))
                    .foregroundColor(.primary)
                    .padding(.top, 30)
                    .padding(.bottom, 17)
                Spacer()
            }
            
            TextField("Assunto", text: $subject, axis: .vertical)
                .lineLimit(1, reservesSpace: true)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("gray0")))
                .foregroundColor(.primary)
            
            TextField("Descreva o seu problema", text: $comment, axis: .vertical)
                .lineLimit(4, reservesSpace: true)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("gray0")))
                .foregroundColor(.primary)
                .padding(.bottom, 10)
            
            HStack(spacing: 12) {
                Button {
                    
                } label: {
                    HStack{
                        Spacer()
                        Text("Cancelar")
                            .font(.system(size: 18))
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.all)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .padding(.bottom, 10)
                }
                        
                Button {
                    
                } label: {
                    HStack{
                        Spacer()
                        Text("Enviar")
                            .font(.system(size: 18))
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.all)
                    .background(Color("gray3"))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .padding(.bottom, 10)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 24)
    }
}

struct ReportComponent_Previews: PreviewProvider {
    static var previews: some View {
        ReportComponent()
    }
}
