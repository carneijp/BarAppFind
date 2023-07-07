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
    @State private var diferentPassword: Bool = false
    
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
            
            if diferentPassword {
                Text("As senha informadas não são compativeis")
                    .foregroundColor(.red)
                    .font(.system(size: 12))
                    .padding(.top, 8)
            }
            
            Button {
                diferentPassword = false
                if password == confirmPassword{
                    if let cliente = cloud.client{
                        cloud.changeUserPassword(client: cliente, password: password)
                        UserDefaults.standard.set(confirmPassword, forKey: "Password")
                        presentation.wrappedValue.dismiss()
                    }
                }else{
                    diferentPassword = true
                    print("Invalida password")
                }
                
            }label: {
                Spacer()
                Text("Salvar")
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                Spacer()
            }
            .background(.white)
            .cornerRadius(24)
            .shadow(color: Color("gray6") ,radius: 3, x: 0, y: 2)
            .padding()
            
            
            Spacer()
        }
    }
}
