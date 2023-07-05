//
//  TesteLoginView.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 12/05/23.
//

import SwiftUI

struct TesteLoginView: View {
    @State private var password: String = ""
    @State private var email: String = ""
    
    var body: some View {
        VStack {
            Text("TELA TESTE DE LOGIN")
            
            TextField("Digite o seu e-mail", text: $email)
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
            
            Button {
                // LOGICA
            } label: {
                Text("Entrar")
            }
        }
    }
}

struct TesteLoginView_Previews: PreviewProvider {
    static var previews: some View {
        TesteLoginView()
    }
}
