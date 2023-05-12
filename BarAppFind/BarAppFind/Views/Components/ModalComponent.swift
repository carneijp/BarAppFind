//
//  ModalComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 11/05/23.
//

import SwiftUI

struct ModalComponent: View {
    @EnvironmentObject var cloud: CloudKitCRUD
    @Environment(\.presentationMode) var presentation
    @State private var email: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var password: String = ""

    
    var body: some View {
        VStack {
            HStack {
                Text("Login com E-mail")
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
            
            Image("trending1")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 200, height: 200)
            
            TextField("Digite o seu e-mail", text: $email)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding(.all)
                .border(.secondary)
                .padding(.horizontal)
            
            TextField("Nome", text: $firstName)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding(.all)
                .border(.secondary)
                .padding(.horizontal)
            
            TextField("Sobrenome", text: $lastName)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding(.all)
                .border(.secondary)
                .padding(.horizontal)
            
            TextField("Senha", text: $password)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding(.all)
                .border(.secondary)
                .padding(.horizontal)
            
            Button{
                cloud.addUser(clients: Clients(email: email, firstName: firstName, password: password, lastName: lastName))
            }label: {
                Text("CRIAR")
            }

            
//            Button {
//
//            } label: {
//                HStack(spacing: 14) {
//                    Image(systemName: "apple.logo")
//
//                    Text("Login com Apple")
//                        .bold()
//                        .font(.system(size: 17))
//                }
//            }
//            .padding(.horizontal, 24)
//            .padding(.vertical, 10)
//            .background(.tertiary.opacity(0.3))
//            .foregroundColor(.primary)
//            .cornerRadius(100)
//            .padding(.bottom, 20)
//
//            Text("ou")
//                .font(.system(size: 18))
//                .padding(.bottom, 20)
//
//            Button {
//
//            } label: {
//                Text("Login com e-mail")
//                    .underline()
//                    .font(.system(size: 18))
//            }
//            .foregroundColor(.primary)

            
            
            Spacer()
        }
//        .background(.blue)
    }
}

struct ModalComponent_Previews: PreviewProvider {
    static var previews: some View {
        ModalComponent()
    }
}
