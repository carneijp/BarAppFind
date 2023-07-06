//
//  TextFieldComponent.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 11/05/23.
//

import SwiftUI

struct TextFieldComponent: View {
    @State private var review: String = ""
    @State private var grade: Double = 0.0
    @EnvironmentObject private var cloud: CloudKitCRUD
    let barName: String
    
    @Binding var viewIndex: Int
    @Binding var showSignIn: Bool
    @Binding var showReviewError: Bool
    
    let pub = NotificationCenter.default
        .publisher(for: NSNotification.Name("addReview"))
    
    var body: some View {
        VStack(alignment: .leading) {
            //            Spacer()
            Text("Queremos a sua avaliação")
                .font(.system(size: 20))
                .bold()
                .padding(.horizontal, 24)
            
            // estrelas
            HStack {
                ForEach(1..<6){ i in
                    Button(){
                        grade = Double(i)
                    }label: {
                        if Double(i) <= grade {
                            Image(systemName: "star.fill")
                                .foregroundColor(.primary)
                                .frame(width: 26, height: 24)
                        }
                        else {
                            Image(systemName: "star")
                                .foregroundColor(.primary)
                                .frame(width: 26, height: 24)
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 8)
            
            // input do usuário
            TextField("Escreva aqui", text: $review, axis: .vertical)
                .lineLimit(4, reservesSpace: true)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("gray0")))
                .foregroundColor(.primary)
                .padding(.horizontal, 24)
            
            HStack(spacing: 10) {
                Button(){
                    review = ""
                    grade = 0.0
                }label: {
                    Text("Cancelar")
                        .foregroundColor(Color("white"))
                        .frame(width: 161, height: 27)
                        .padding(.vertical, 5)
                        .background(Color("gray4"))
                        .cornerRadius(12)
                        .shadow(radius: 3, y: 2)
                }
                
                Spacer()
                
                Button(){
                    if let client = cloud.client {
                        if self.grade > 0.0{
                            let review: Review = Review(writerEmail: client.email, writerName: client.firstName, grade: grade, description: review, barName: barName)
                            cloud.addReview(review: review)
                        } else {
                            if viewIndex == 1 {
                                showReviewError = true
                            }
                        }
                    }
                    else {
                        if viewIndex == 1 {
                            showSignIn = true
                        }
                    }

                    
                } label: {
                    Text("Enviar")
                        .foregroundColor(Color("white"))
                        .frame(width: 161, height: 27)
                        .padding(.vertical, 5)
                        .background(Color("gray7"))
                        .cornerRadius(12)
                        .shadow(radius: 3, y: 2)
                }
                
            }
            .padding(.top, 3)
            .padding(.horizontal, 24)
            
        }
        .onReceive(pub) { output in
            if let review = output.object as? Review {
                self.cloud.reviewListByBar.append(review)
            }
        }
    }
}

//struct TextFieldComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        TextFieldComponent(barName: "aa", showSignIn: .constant(true), viewIndex: .constant(1))
//    }
//}
