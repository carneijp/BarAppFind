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
                                .foregroundColor(.black)
                                .frame(width: 26, height: 24)
                        }
                        else {
                            Image(systemName: "star")
                                .foregroundColor(.black)
                                .frame(width: 26, height: 24)
                        }
                    }
                }
            }
            
            // input do usuário
            TextField("Escreva aqui", text: $review, axis: .vertical)
                .lineLimit(5, reservesSpace: true)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
                .foregroundColor(.black)
            //                .padding()
            //                .frame(width: 342, height: 104)
            
            HStack() {
                Group {
                    Button(){
                        review = ""
                        grade = 0.0
                    }label: {
                        Text("Cancelar")
                            .foregroundColor(.black)
                            .frame(width: 161, height: 27)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    Spacer()
                    Button(){
                        if self.grade > 0.0 && self.review != ""{
                            if let client = cloud.client {
                                cloud.addReview(review: Review(writerEmail: client.email, writerName: client.firstName, grade: self.grade, description: self.review, barName: self.barName))
                                
                            }
                        }
                    } label: {
                        Text("Enviar")
                            .foregroundColor(.black)
                            .frame(width: 161, height: 27)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                }
            }
            //            Spacer()
        }
        //        .padding(.horizontal)
    }
}

struct TextFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldComponent(barName: "aa")
    }
}
