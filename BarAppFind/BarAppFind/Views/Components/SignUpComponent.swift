//
//  ModalComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 11/05/23.
//

import SwiftUI

struct SignUpComponent: View {
    @EnvironmentObject var cloud: CloudKitCRUD
    @Environment(\.presentationMode) var presentation
    @State private var email: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var password: String = ""
    @State private var showLogin: Bool = false

    
    var body: some View {
        VStack {
            HStack {
                Text("Cadastre o seu E-mail")
                    .font(.system(size: 16))
                .bold()
                .padding(.leading, 85)
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
            
            
            // Inputs do Usuário
            Group {
                TextField("Digite o seu e-mail", text: $email)
                
                TextField("Nome", text: $firstName)
                
                TextField("Sobrenome", text: $lastName)
                
                TextField("Senha", text: $password)
            }
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

            Button {
                showLogin = true
            } label: {
                Text("Fazer Login")
                    .underline()
            }
            .padding(.top)
            .foregroundColor(.primary)

            Spacer()
        }
        .sheet(isPresented: $showLogin) {
            SignInComponent()
        }
        
        .onAppear() {
            // verificar se está logado
            // se estiver logado
            // presentation.wrappedValue.dismiss()
        }
        
    }
}

struct ModalComponent_Previews: PreviewProvider {
    static var previews: some View {
        SignUpComponent()
    }
}
