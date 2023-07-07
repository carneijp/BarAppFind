//
//  EditProfileComponent.swift
//  Onde
//
//  Created by Eduardo Pretto on 24/05/23.
//

import SwiftUI

struct EditProfileComponent: View {
    @EnvironmentObject private var cloud: CloudKitCRUD
    @Environment(\.presentationMode) var presentation
    //    var cliente: Clients
    @State var firstName: String
    @State var lastName: String
    @State var email: String
    
    var body: some View {
        VStack{
            HStack{
                Text("Alterar dados da conta")
                    .font(.system(size: 16))
                    .bold()
                    .padding(.leading, UIScreen.main.bounds.width/3.7)
                //                .background(.blue)
                
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
                Text("Alterar dados da conta")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
//                    .padding(.top, 30)
                    .padding(.bottom, 17)
                    .padding(.horizontal, 24)
                Spacer()
            }
            
            TextField("Nome", text: $firstName, axis: .vertical)
                .lineLimit(1, reservesSpace: true)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("gray8")))
                .foregroundColor(.secondary)
                .padding(.horizontal, 24)
            
            TextField("Sobrenome", text: $lastName, axis: .vertical)
                .lineLimit(1, reservesSpace: true)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("gray8")))
                .foregroundColor(.secondary)
                .padding(.horizontal, 24)
            
            TextField("E-mail", text: $email, axis: .vertical)
                .lineLimit(1, reservesSpace: true)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("gray8")))
                .foregroundColor(.secondary)
                .padding(.horizontal, 24)
            
            Button {
                if let cliente = cloud.client{
                    let emailAntigo: String = cliente.email
                    cliente.firstName = firstName
                    cliente.lastName = lastName
                    cliente.email = email
                    cloud.changeUserInfo(client: cliente, emailAntigo: emailAntigo)
                }
                presentation.wrappedValue.dismiss()
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

//struct EditProfileComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfileComponent()
//    }
//}
