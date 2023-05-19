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
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding(.all)
                .clipShape(Circle())
                .shadow(radius: 1, x: 0, y: 2)
                .padding(.top, 30)
                .padding(.bottom, 10)
            
            // Inputs do Usuário
            Group {
                TextField("Digite o seu e-mail", text: $email)
                
                TextField("Nome", text: $firstName)
                
                TextField("Sobrenome", text: $lastName)
                
                SecureField("Senha", text: $password)
            }
            .font(.system(size: 16))
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background()
            .cornerRadius(8)
            .padding(.horizontal, 24)
            .shadow(color: .primary.opacity(0.2) ,radius: 2, y: 2)
            
            
            // Botão de Cadastrar Conta
            Button{
                cloud.addUser(clients: Clients(email: email, firstName: firstName, password: password, lastName: lastName)){}
                presentation.wrappedValue.dismiss()
            }label: {
                HStack {
                    Spacer()
                    Text("Vamos lá!")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .padding(.vertical, 10)
//                    .padding(.horizontal, 20)
                    Spacer()
                }
            }
            .background(Color("login"))
            .cornerRadius(10)
            .padding(.top, 20)
            .padding(.horizontal, 24)
            
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
