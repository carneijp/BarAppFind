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
                Text("Seus dados atuais: (Toque para alterar)")
                    .padding()
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .padding(.top, 12)
                    .padding(.horizontal, 24)
                Spacer()
            }
            
            Group {
                TextField("Nome", text: $firstName, axis: .vertical)
                
                TextField("Sobrenome", text: $lastName, axis: .vertical)
                
                TextField("E-mail", text: $email, axis: .vertical)
            }
            .lineLimit(1, reservesSpace: true)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color("gray0").opacity(0.6)))
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
        .navigationTitle("Alterar dados da conta")
    }
}

//struct EditProfileComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfileComponent()
//    }
//}
