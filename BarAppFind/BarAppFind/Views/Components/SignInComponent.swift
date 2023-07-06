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
    @State private var invalidPassword: Bool = false
    
    
    var body: some View {
        VStack {
            
            // Header da Sheet / Modal
            HStack() {
                Text("Login")
                    .font(.system(size: 16))
                    .bold()
                    .padding(.leading, UIScreen.main.bounds.width/2.6)
                //                .background(.blue)
                
                Spacer()
                
                HStack() {
                    Button {
                        presentation.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "x.circle")
                }
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
//            Group {
//                TextField("Digite o seu e-mail", text: $email)
//
//
//                SecureField("Senha", text: $password)
//            }
//            .font(.system(size: 16))
//            .textInputAutocapitalization(.never)
//            .disableAutocorrection(true)
//            .padding(.vertical, 10)
//            .padding(.horizontal)
//            .background()
//            .cornerRadius(8)
//            .padding(.horizontal, 24)
//            .shadow(color: .primary.opacity(0.2) ,radius: 2, y: 2)
//
//
////            aqui
//            if invalidPassword{
//                Text("Senha ou email incorretos, digite novamente")
//                    .foregroundColor(.red)
//                    .font(.system(size: 12))
//                    .padding(.top, 8)
//            }
            
            
            VStack  {
                // Botão de Logar
//                Button {
//                    cloud.validateClientLogin(email: email, password: password) { result in
//                        if result{
//                            let login: String = $email.wrappedValue
//                            let senha: String = $password.wrappedValue
//                            UserDefaults.standard.set(login, forKey: "Email")
//                            UserDefaults.standard.set(senha, forKey: "Password")
//                            print("salvei")
//                            presentation.wrappedValue.dismiss()
//                        }
//                        else{
//                            print("login ou senha invalidos")
//                            invalidPassword = true
//                        }
//                    }
//                } label: {
//                    HStack {
//                        Spacer()
//                        Text("Login com E-mail")
//                            .underline()
//                            .foregroundColor(.primary)
//                            .font(.system(size: 16))
//                            .padding(.vertical, 10)
//                        Spacer()
//                    }
//                }
//                .background(Color("darkBlueGradient"))
//                .cornerRadius(10)
                
                Button{
                    print("aa")
                } label: {
                    HStack {
//                        Spacer()
                        Text("Login com E-mail")
                            .underline()
                            .foregroundColor(.primary)
                            .font(.system(size: 16))
                            .padding(.vertical, 10)
//                        Spacer()
                    }
                }
                    
                Text("ou")
                    .font(.system(size: 16))
                
                SignInApple()
                
                Spacer()
                
                // Botão de Cadastrar
                
                Button {
                    showSignUp = true
                } label: {
                    HStack {
                        Spacer()
                        Text("Criar Conta")
                            .underline()
                            .foregroundColor(.primary)
                            .font(.system(size: 16))
                            .padding(.vertical, 10)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)

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
