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
    @State var showError: Bool = false
    @State var descriptionError: String = ""
    @State var showSuccess: Bool = false
    @State var descriptionSuccess: String = ""
    
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
                    showError = false
                    showSuccess = false
                    descriptionError = ""
                    descriptionSuccess = ""
                    self.comment = ""
                    self.subject = ""
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
                    showError = false
                    showSuccess = false
                    if !$comment.wrappedValue.isEmpty && !$subject.wrappedValue.isEmpty {
                        cloud.addReport(assunto: subject, texto: comment) { saida in
                            if saida{
                                showSuccess = true
                                descriptionSuccess = "Seu report foi cadastrado com sucesso!"
                                DispatchQueue.main.asyncAfter(deadline: .now()+1.5){
                                    presentation.wrappedValue.dismiss()
                                }
                            }else{
                                showError = true
                                descriptionError = "Não foi possivel cadastrar o seu report, tente novamente mais tarde, ou verifique sua conexão."
                            }
                        }
                    }else{
                        showError = true
                        descriptionError = "Para enviar um report, o assunto e o comentario devem ser preenchidos."
                    }
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
            
            if showError{
                Text(descriptionError)
                    .foregroundColor(.red)
                    .font(.system(size: 12))
                    .padding(.top, 8)
            }
            
            if showSuccess {
                Text(descriptionSuccess)
                    .foregroundColor(.green)
                    .font(.system(size: 12))
                    .padding(.top, 8)
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
