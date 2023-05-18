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
            
            // Header da Sheet
            HStack {
                Text("Cadastre o seu E-mail")
                    .font(.system(size: 16))
                .bold()
                .padding(.leading, 85)
                
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
            
            // Logo do App
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
                
                SecureField("Senha", text: $password)
            }
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding(.all)
            .border(.secondary)
            .padding(.horizontal)

            
            // Botão de Cadastrar Conta
            Button{
                cloud.addUser(clients: Clients(email: email, firstName: firstName, password: password, lastName: lastName)){}
                presentation.wrappedValue.dismiss()
            }label: {
                Text("CRIAR")
            }
            .padding(.top)

            Spacer()
        }
        // Faz aparecer a sheet de Cadastrar usuário
        .sheet(isPresented: $showLogin) {
            SignInComponent()
        }
        
        // Verifica se o usuário está logado quando a Sheet aparecer
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
