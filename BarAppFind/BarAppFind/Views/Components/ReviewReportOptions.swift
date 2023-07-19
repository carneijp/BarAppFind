//
//  ReviewReportOptions.swift
//  Onde
//
//  Created by Joao Paulo Carneiro on 17/07/23.
//
import SwiftUI
import Foundation


struct ReviewReportOptions: View {
    @Binding var ispresentedReportOptions: Bool
    var selectedReview: Review
    var body: some View {
        if ispresentedReportOptions{
            ZStack{
                Color(.black)
                    .opacity(0.5)
                VStack{
                    Spacer()
                    
                    VStack {
                        Text("NOME AQUI")
                        Divider()
                        Button{
                            
                        }label: {
                            Text("Denunciar esse comentario")
                                .foregroundColor(.red)
                                .frame(width: UIScreen.main.bounds.width)
                                .padding(.vertical)
                        }
                    }
                    .background(Color(.white))
                    .frame(width: UIScreen.main.bounds.width)
                    .cornerRadius(10)
                    
                    Button{
                        ispresentedReportOptions = false
                    }label:{
                            Text("Cancelar")
                                .foregroundColor(.blue)
                                .frame(width: UIScreen.main.bounds.width)
                                .padding(.vertical)
                    }
                    .background(Color(.white))
                    .cornerRadius(10)
//                    .padding()
                }
//                .padding(.horizontal)
                .padding(.bottom, UIScreen.main.bounds.height * 0.165)
            }
            
        }
    }
}
