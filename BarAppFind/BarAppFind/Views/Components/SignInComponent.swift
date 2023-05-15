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

    
    var body: some View {
        VStack {
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
            
            Image("trending1")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 200, height: 200)
            
            
            // Inputs do Usuário
            Group {
                TextField("Digite o seu e-mail", text: $email)

                
                TextField("Senha", text: $password)
            }
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding(.all)
            .border(.secondary)
            .padding(.horizontal)
            
            Button {
                presentation.wrappedValue.dismiss()
            } label: {
                Text("Entrar")
            }

            
            Spacer()
        }
        
    }
}

struct SignInComponent_Previews: PreviewProvider {
    static var previews: some View {
        SignInComponent()
    }
}
