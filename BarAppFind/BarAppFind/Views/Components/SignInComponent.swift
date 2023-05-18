//
//  SignInComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 15/05/23.
//

import SwiftUI

struct SignInComponent: View {
    @EnvironmentObject var cloud: CloudKitCRUD
    @Environment(\.presentationMode) var presentation
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showSignUp: Bool = false

    
    var body: some View {
        VStack {
            
            // Header da Sheet / Modal
            HStack {
                Text("Faça o seu Login")
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
            
            
            // Logo do App
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding(.all)
                .clipShape(Circle())
                .shadow(radius: 1, x: 0, y: 2)
                .padding(.top, 30)
                .padding(.bottom, 20)
            
            
            // Inputs do Usuário
            Group {
                TextField("Digite o seu e-mail", text: $email)

                
                SecureField("Senha", text: $password)
            }
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding(.all)
            .border(.secondary)
            .padding(.horizontal)
            
            // Botão de Logar
            Button {
                cloud.validateClientLogin(email: email, password: password) { result in
                    if result{
                        let login: String = $email.wrappedValue
                        let senha: String = $password.wrappedValue
                            UserDefaults.standard.set(login, forKey: "Email")
                            UserDefaults.standard.set(senha, forKey: "Password")
                            print("salvei")
                    }
                    else{
                        print("login ou senha invalidos")
                    }
                }
                presentation.wrappedValue.dismiss()
            } label: {
                Text("Entrar")
            }
            .padding(.vertical)
            
            // Botão de Cadastrar
            
            Button {
                showSignUp = true
            } label: {
                Text("Quero me cadastrar")
            }
            
            
            Spacer()
        }
        .sheet(isPresented: $showSignUp) {
            SignUpComponent()
        }
        
    }
}

struct SignInComponent_Previews: PreviewProvider {
    static var previews: some View {
        SignInComponent()
    }
}
