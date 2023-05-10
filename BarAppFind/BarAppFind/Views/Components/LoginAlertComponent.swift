//
//  LoginAlertComponent.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 10/05/23.
//

import SwiftUI

struct LoginAlertComponent: View {
    var body: some View {
        VStack{
            HStack(alignment: .top){
                Image(systemName: "exclamationmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 27, height: 26)
                
                VStack(alignment: .leading){
                    Text("Login necessário")
                        .font(.system(size: 16))
                        .padding(.bottom, 5)
                    
                    Text("Para publicar reviews realize o login")
                        .font(.system(size: 14))

                }
                Spacer()
            }
            .padding(.bottom, 20)
            HStack{
                Text("Mais tarde")
                    .font(.system(size: 14))
                    .padding(.horizontal)
                    .padding(.vertical, 2)
                    .background(Color.green)
                    .cornerRadius(10)
                
                Text("Fazer Login")
                    .font(.system(size: 14))
                    .padding(.horizontal)
                    .padding(.vertical, 2)
                    .background(Color.green)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(.yellow)
        .cornerRadius(20)
        .padding(.all, 30)
    }
}

struct LoginAlertComponent_Previews: PreviewProvider {
    static var previews: some View {
        LoginAlertComponent()
    }
}
