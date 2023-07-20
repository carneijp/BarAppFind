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
    @State private var loginSucess: Bool = false
    @State private var isLoading: Bool = false
    @State private var isEmpty: Bool = false
    
    
    var body: some View {
        ZStack{
            ScrollView {
                
                // Logo do App
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.all)
                    .clipShape(Circle())
                    .shadow(radius: 1, x: 0, y: 2)
                    .padding(.bottom, 20)
                
                
                // Inputs do Usuário
                Group {
                    TextField("Digite o seu e-mail", text: $email)
                        .keyboardType(.emailAddress)
                    
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
                
                
                if invalidPassword{
                    Text("Senha ou email incorretos, digite novamente")
                        .foregroundColor(.red)
                        .font(.system(size: 12))
                        .padding(.top, 8)
                }
                if isEmpty{
                    Text("Todos os campos devem estar preenchidos")
                        .foregroundColor(.red)
                        .font(.system(size: 12))
                        .padding(.top, 8)
                }
                
                VStack  {
                    // Botão de Logar
                    Button(action: {
                        email = email.trimmingCharacters(in: .whitespaces)
                        password = password.trimmingCharacters(in: .whitespaces)
                        isLoading = true
                        isEmpty = false
                        if(!email.isEmpty && !password.isEmpty){
                            cloud.validateClientLogin(email: email, password: password) { result in
                                if result {
                                    isLoading = false
                                    let login: String = $email.wrappedValue
                                    let senha: String = $password.wrappedValue
                                    UserDefaults.standard.set(login, forKey: "Email")
                                    UserDefaults.standard.set(senha, forKey: "Password")
                                    print("salvei")
                                    self.loginSucess = true
                                    //                            presentation.wrappedValue.dismiss()
                                } else {
                                    isLoading = false
                                    print("login ou senha invalidos")
                                    invalidPassword = true
                                }
                            }
                        }else{
                            isLoading = false
                            isEmpty = true
                        }
                        
                    }) {
                        HStack {
                            Spacer()
                            Text("Entrar")
                                .foregroundColor(.primary)
                                .font(.system(size: 18))
                                .padding(.vertical, 10)
                            Spacer()
                        }
                        .background(Color.white)
                        .cornerRadius(24)
                        .shadow(color: Color("gray6"), radius: 3, x: 0, y: 2)
                    }
                    
                    SignInApple(loginSuccess: $loginSucess)
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
                
                Spacer()
                
                // Botão de Cadastrar
                
                
                Spacer()
            }
            .navigationBarTitle("Login", displayMode: .inline)
            .navigationDestination(isPresented: $loginSucess) {
                ProfileView()
            }
            .navigationDestination(isPresented: $showSignUp) {
                SignUpComponent()
            }
            
            if isLoading {
                LoadingViewModel()
                    .padding(.bottom, 130)
            }
        }
    }
}

struct SignInComponent_Previews: PreviewProvider {
    static var previews: some View {
        SignInComponent()
    }
}
