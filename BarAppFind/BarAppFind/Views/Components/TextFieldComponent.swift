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
        VStack(alignment: .leading){
            Text("Queremos sua avaliação")
            
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
            
            TextField("Escreva aqui", text: $review)
            //                            .font(Font.system(size: 14))
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
                .foregroundColor(.black)
                .frame(width: 342, height: 104)

            HStack{
                Spacer()
                
                Text("Cancelar")
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
                    .onTapGesture {
                        review = ""
                        grade = 0.0
                        print("aa")
                    }
                
                Spacer()
                Button(){
                    if self.grade > 0.0 && self.review != ""{
                        if let client = cloud.client {
                            cloud.addReview(review: Review(writerEmail: client.email, writerName: client.firstName, grade: self.grade, description: self.review, barName: self.barName))
                            
                        }
//                        else{
//                                LoginAlertComponent()
//                            }
                    }
                }label: {
                    Text("Enviar")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                

                    
                
                Spacer()
            }
            
            
        }
        .padding()
    }
}

struct TextFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldComponent(barName: "aa")
    }
}
