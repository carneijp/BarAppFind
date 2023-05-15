//
//  TextFieldComponent.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 11/05/23.
//

import SwiftUI

struct TextFieldComponent: View {
    @State var review: String = ""
    @State var grade: Double = 0.0
    @EnvironmentObject var cloud: CloudKitCRUD
    let barName: String
    
    let pub = NotificationCenter.default
                .publisher(for: NSNotification.Name("addReview"))
    
    var body: some View {
        VStack(alignment: .leading) {
            //            Spacer()
            Text("Queremos sua avaliação")
                .font(.system(size: 20))
                .bold()
            
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
            
            // input do usuário
            TextField("Escreva aqui", text: $review, axis: .vertical)
                .lineLimit(5, reservesSpace: true)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("gray0")))
                .foregroundColor(.primary)
            //                .padding()
            //                .frame(width: 342, height: 104)
            
            HStack() {
                Group {
                    Button(){
                        review = ""
                        grade = 0.0
                    }label: {
                        Text("Cancelar")
                            .foregroundColor(.primary)
                            .frame(width: 161, height: 27)
                            .background(Color("gray4"))
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                    Button(){
                        if self.grade > 0.0{
                            if let client = cloud.client {
                                let review: Review = Review(writerEmail: client.email, writerName: client.firstName, grade: grade, description: review, barName: barName)
                                cloud.addReview(review: review)
                            }
                        }
                    } label: {
                        Text("Enviar")
                            .foregroundColor(.primary)
                            .frame(width: 161, height: 27)
                            .background(Color("gray1"))
                            .cornerRadius(10)
                    }
                }
            }
            //            Spacer()
        }
//        .padding(.horizontal)
        .onReceive(pub) { output in
            if let review = output.object as? Review {
                self.cloud.reviewListByBar.append(review)
            }
        }
    }
}

struct TextFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldComponent(barName: "aa")
    }
}