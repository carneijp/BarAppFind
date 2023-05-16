//
//  CustomAlertComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 11/05/23.
//

import SwiftUI

struct LoginAlertComponent: View {
    var title: String
    var description: String
    @Binding var isShow: Bool
    @State private var showSignIn: Bool = false
//    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Textos
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: "exclamationmark.circle.fill")
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(self.title)
                        .font(.system(size: 16))
                    
                    Text(self.description)
                        .font(.system(size: 14))
                }
            }
            
            // Botões do PopUp
            HStack {
                Button {
                    self.isShow = false
                } label: {
                    Text("Mais tarde")
                        .font(.system(size: 14))
                        .foregroundColor(Color("white"))
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 24)
                .background(Color("gray4"))
                .cornerRadius(12)
                
                Spacer()
                
                Button {
                    showSignIn = true
                    self.isShow = false
                } label: {
                    Text("Fazer Login")
                        .font(.system(size: 14))
                        .foregroundColor(Color("white"))
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 24)
                .background(Color("gray1"))
                .cornerRadius(12)

            }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 24)
        .frame(width: UIScreen.main.bounds.width - 48)
        .background(Color("white"))
        .cornerRadius(12)
        .shadow(color: .primary.opacity(0.1), radius: 5, x: 0, y: 4)
        .animation(.spring())
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 20)
        .background(.secondary.opacity(0.6))
        .offset(y: isShow ? -10 : UIScreen.main.bounds.height)
        .sheet(isPresented: $showSignIn) {
            SignInComponent()
        }
    }
}

struct CustomAlertComponent_Previews: PreviewProvider {
    static var previews: some View {
        LoginAlertComponent(title: "Login Necessário", description: "Para acessar as suas conquistas e os detalhes da sua conta, realize o login.", isShow: .constant(true) )
    }
}
