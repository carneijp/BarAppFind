//
//  ReportComponent.swift
//  Onde
//
//  Created by Guilherme Borges Cavali on 05/07/23.
//

import SwiftUI

struct ReportComponent: View {
    
    @EnvironmentObject private var cloud: Model
    @Environment(\.presentationMode) var presentation
    @State var isLoading: Bool = false
    @State var subject: String = ""
    @State var comment: String = ""
    @State var showError: Bool = false
    @State var descriptionError: String = ""
    @State var showSuccess: Bool = false
    @State var descriptionSuccess: String = ""
    
    var body: some View {
        if isLoading {
            LoadingViewModel()
        }else{
            VStack {
                HStack{
                    Text("Reportar Problema")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .padding(.top, 30)
                        .padding(.bottom, 17)
                    Spacer()
                }
                
                TextField("Assunto", text: $subject, axis: .vertical)
                    .font(.system(size: 14))
                    .lineLimit(1, reservesSpace: true)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("gray0")))
                    .foregroundColor(.primary)
                
                TextField("Descreva o seu problema", text: $comment, axis: .vertical)
                    .font(.system(size: 14))
                    .lineLimit(5, reservesSpace: true)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color("gray0")))
                    .foregroundColor(.primary)
                    .padding(.bottom, 10)
                
                
                Button {
                    showError = false
                    showSuccess = false
                    isLoading = true
                    if !$comment.wrappedValue.isEmpty && !$subject.wrappedValue.isEmpty {
                        guard let report = Report(assunto: subject, descricao: comment, userID: cloud.client?.userID ?? "") else { return }
                        cloud.addReport(report: report) { saida in
                            if saida{
                                showSuccess = true
                                isLoading = false
                                descriptionSuccess = "Seu report foi cadastrado com sucesso!"
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                    presentation.wrappedValue.dismiss()
                                }
                            }else{
                                showError = true
                                isLoading = false
                                descriptionError = "Não foi possivel cadastrar o seu report, tente novamente mais tarde, ou verifique sua conexão."
                            }
                        }
                    }else{
                        showError = true
                        isLoading = false
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
                    .padding(.vertical, 12)
                    .background(.white)
                    .cornerRadius(30)
                    .shadow(radius: 2)
                    .padding(.bottom, 10)
                }
                
                
                
                
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
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.vertical, 12)
                    .background(Color("gray1"))
                    .cornerRadius(30)
                    .shadow(radius: 2)
                    .padding(.bottom, 10)
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
            .navigationTitle("Reportar problema")
            .padding(.horizontal, 24)
        }
    }
}

struct ReportComponent_Previews: PreviewProvider {
    static var previews: some View {
        ReportComponent()
    }
}
