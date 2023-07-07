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
    @State private var emailAlreadyInUse: Bool = false
    @State private var emptyText: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            
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
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.all)
                .clipShape(Circle())
                .shadow(radius: 1, x: 0, y: 2)
//                .padding(.top, 30)
                .padding(.bottom, 20)
            
            Text("Que bom ter você aqui!")
                .font(.system(size: 27))
                .bold()
//                .padding(.top, 20)
            
            // Inputs do Usuário
            Group {
                TextField("Digite o seu e-mail", text: $email)
                
                TextField("Nome", text: $firstName)
//                    .padding(.vertical, 20)
                
                TextField("Sobrenome", text: $lastName)
//                    .padding(.vertical, 20)

                
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
            
            if emailAlreadyInUse{
                Text("Email informado já está cadastrado")
                    .foregroundColor(.red)
                    .font(.system(size: 12))
                    .padding(.top, 8)
            }
            if emptyText {
                Text("Todos os campos devem ser preenchidos com dados válidos.")
                    .foregroundColor(.red)
                    .font(.system(size: 12))
                    .padding(.top, 8)
            }
            
            // Botão de Cadastrar Conta
            Button{
                emailAlreadyInUse = false
                emptyText = false
                if(email != "" && password != "" && firstName != "" && lastName != ""){
                    cloud.addUser(clients: Clients(email: email, firstName: firstName, password: password, lastName: lastName)){ result in
                        if result{
                            presentation.wrappedValue.dismiss()
                        }else{
                            print("usuario ja existente")
                            emailAlreadyInUse = true
                        }
                    }
                    
                }else{
                    emptyText = true
                    print("informcacoes devem estar preenchidas")
                }

            }label: {
                HStack {
                    Spacer()
                    Text("Vamos lá!")
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
            .padding(.horizontal, 24)
            .padding(.top, 32)
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
