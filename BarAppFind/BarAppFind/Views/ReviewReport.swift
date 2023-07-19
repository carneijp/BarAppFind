//
//  ReviewReport.swift
//  Onde
//
//  Created by Joao Paulo Carneiro on 18/07/23.
//

import Foundation
import SwiftUI

struct ReviewReport: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var cloud: CloudKitCRUD
    @Binding var showSheet: Bool
    var review: Review
    @State var hasFinished: Bool = false
    
    var reportTipes: [String] = ["É spam", "Símbolos ou discurso de ódio", "Bullying ou assédio", "Informação falsa", "Linguagem inapropriada", "Não gostei", "Outros assuntos"]
    var body: some View {
        VStack{
            ZStack{
                VStack{
                    Text("Denunciar")
                }
                .padding(.top)
                HStack{
                    Spacer()
                    Button{
                        presentation.wrappedValue.dismiss()
                    }label: {
                        Image(systemName: "x.circle")
                    }
                }
                .padding(.top)
                .padding(.trailing)
            }
            Divider()
            Text("Por que você quer denunciar esse comentário?")
                .font(.system(size: 16))
                .bold()
                .padding(.top)
            Text("Sua denúncia estará visivel somente para nossa equipe")
                .foregroundColor(Color(.gray))
                .font(.system(size: 14))
                .padding(.bottom)
            Divider()
            List{
                ForEach(reportTipes, id: \.self) { report in
                    Button {
                        hasFinished = true
                        
                        let reviewReport = ReportReview(clientInformerEmail: cloud.client?.email ?? "Usuario não cadastrado", clientInformerID: cloud.client?.userID ?? "", reportBarName: review.barName, reportWirterEmail: review.writerEmail, reportDescription: review.description, reportWriterID: review.writerId, reportReason: report)
                        cloud.addReviewReport(reportReview: reviewReport) { _ in }
                    }label: {
                        HStack{
                            Text(report)
                                .foregroundColor(Color(.gray))
                                .font(.system(size: 16))
                            Spacer()
                            Image(systemName: "chevron.forward")
                        }
                    }
                    
                    
                }
            }.listStyle(.plain)
            Spacer()
                .sheet(isPresented: $hasFinished) {
                    ReportReviewConclusion(showSheet: $showSheet)
                }
        }
    }
}
