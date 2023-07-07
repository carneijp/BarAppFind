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
                .frame(width: 100, height: 100)
                .padding(.all)
                .clipShape(Circle())
                .shadow(radius: 1, x: 0, y: 2)
//                .padding(.top, 10)
                .padding(.bottom, 20)
            
            
            // Inputs do Usuário
            Group {
                TextField("Digite o seu e-mail", text: $email)


                SecureField("Senha", text: $password)
            }
            .font(.system(size: 16))
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color("gray8"))
            .cornerRadius(8)
            .padding(.horizontal, 24)
//            .shadow(color: .primary.opacity(0.2) ,radius: 2, y: 2)


//            aqui
            if invalidPassword{
                Text("Senha ou email incorretos, digite novamente")
                    .foregroundColor(.red)
                    .font(.system(size: 12))
                    .padding(.top, 8)
            }
            
            
            VStack  {
                // Botão de Logar
                Button(action: {
                    cloud.validateClientLogin(email: email, password: password) { result in
                        if result {
                            let login: String = $email.wrappedValue
                            let senha: String = $password.wrappedValue
                            UserDefaults.standard.set(login, forKey: "Email")
                            UserDefaults.standard.set(senha, forKey: "Password")
                            print("salvei")
                            presentation.wrappedValue.dismiss()
                        } else {
                            print("login ou senha invalidos")
                            invalidPassword = true
                        }
                    }
                }) {
                    HStack {
                        Spacer()
                        Text("Entrar")
//                            .underline()
                            .foregroundColor(.primary)
                            .font(.system(size: 18))
                            .padding(.vertical, 10)
                        Spacer()
                    }
                    .background(Color.white)
                    .cornerRadius(24)
                    .shadow(color: Color("gray6"), radius: 3, x: 0, y: 2)
                }
                
                SignInApple()
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
                
                Text("ou")
                    .font(.system(size: 20))
                    .foregroundColor(Color("gray1"))
                    .padding(.vertical, 20)
                
                Button {
                    showSignUp = true
                } label: {
                    HStack {
                        Spacer()
                        Text("Criar conta")
//                            .underline()
                            .foregroundColor(.primary)
                            .font(.system(size: 18))
                            .padding(.vertical, 10)
                        Spacer()
                    }
                    .background(Color.white)
                    .cornerRadius(24)
                    .shadow(color: Color("gray6"), radius: 3, x: 0, y: 2)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            
//                Button{
//                    print("aa")
//                } label: {
//                    HStack {
////                        Spacer()
//                        Text("Login com E-mail")
//                            .underline()
//                            .foregroundColor(.primary)
//                            .font(.system(size: 16))
//                            .padding(.vertical, 10)
////                        Spacer()
//                    }
//                }
                    
                
                
                Spacer()
                
                // Botão de Cadastrar
                

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
