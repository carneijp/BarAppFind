//
//  EditProfileComponent.swift
//  Onde
//
//  Created by Eduardo Pretto on 24/05/23.
//

import SwiftUI

struct EditPasswordComponent: View {
    @EnvironmentObject private var cloud: CloudKitCRUD
    @Environment(\.presentationMode) var presentation
//    var cliente: Clients
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Text("Alterar senha")
                    .font(.system(size: 16))
                    .bold()
                    .padding(.leading, UIScreen.main.bounds.width/3.7)
                
                Spacer()
                
                Button {
                    presentation.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "x.circle")
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(.secondary.opacity(0.05))
            .padding(.bottom, 30)
            HStack{
                Text("Alterar senha")
                    .font(.system(size: 18))
                    .foregroundColor(.secondary)
                    .padding(.top, 30)
                    .padding(.bottom, 17)
                    .padding(.horizontal, 24)
                Spacer()
            }
            
            TextField("Nova senha", text: $password, axis: .vertical)
                .lineLimit(1, reservesSpace: true)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("gray0")))
                .foregroundColor(.primary)
                .padding(.horizontal, 24)
            
            TextField("Confirmar nova senha", text: $confirmPassword, axis: .vertical)
                .lineLimit(1, reservesSpace: true)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("gray0")))
                .foregroundColor(.primary)
                .padding(.horizontal, 24)
            
            Button {
                if password == confirmPassword{
                    if let cliente = cloud.client{
                        cloud.changeUserPassword(client: cliente, password: password)
                    }
                }else{
                    print("Invalida password")
                }
                
            }label : {
                Text("Salvar")
                    .foregroundColor(Color("white"))
                    .frame(width: 178, height: 53)
                    .background(Color("gray1"))
            }
            .cornerRadius(10)
            .padding(.top)
            
            
            Spacer()
        }
    }
}
