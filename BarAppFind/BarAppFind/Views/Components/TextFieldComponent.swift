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
            Text("Queremos sua avaliação")
            
            // estrelas
            HStack {
                ForEach(1..<6){ i in
                    Button(){
                        grade = Double(i)
                    }label: {
                        if Double(i) <= grade {
                            Image(systemName: "star.fill")
                                .foregroundColor(.black)
                        }
                        else {
                            Image(systemName: "star")
                                .foregroundColor(.black)
                        }
                            
                    }
                }
            }
            .padding(.top)
            
            // input do usuário
            TextField("Escreva aqui", text: $review)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
                .foregroundColor(.black)
                .frame(width: 342, height: 104)

            HStack(spacing: 20) {
                Group {
                    Text("Cancelar")
                        .onTapGesture {
                            review = ""
                            grade = 0.0
                            print("aa")
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(10)
                    
                    Button(){
                        if self.grade > 0.0 && self.review != ""{
                            if let client = cloud.client {
                                cloud.addReview(review: Review(writerEmail: client.email, writerName: client.firstName, grade: self.grade, description: self.review, barName: self.barName))
                                
                            }
                            //                        else{
                            //                                LoginAlertComponent()
                            //                            }
                        }
                    } label: {
                        Text("Enviar")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 10)
            }
            .background(.blue)
  
        }
//        .padding()
//        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(.red)
    }
}

struct TextFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldComponent(barName: "aa")
    }
}
