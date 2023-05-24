//
//  SignInApple.swift
//  Onde
//
//  Created by Joao Paulo Carneiro on 24/05/23.
//

import SwiftUI
import AuthenticationServices

struct SignInApple: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("Email") var email: String = ""
    @AppStorage("FirstName") var firstName: String = ""
    @AppStorage("LastName") var lastName: String = ""
    @AppStorage("UserID") var userId: String = ""
    var body: some View {
        VStack{
            SignInWithAppleButton { request in
                request.requestedScopes = [.email, .fullName]
            } onCompletion: { result in
                switch result{
                case .success(let auth):
                    
                    switch auth.credential{
                    case let credential as ASAuthorizationAppleIDCredential:
                        let userId = credential.user
                        let email = credential.email
                        let firstName = credential.fullName?.givenName
                        let lastName = credential.fullName?.familyName
                        
                        self.email = email ?? ""
                        self.userId = userId
                        self.lastName = lastName ?? ""
                        self.firstName = firstName ?? ""
                    default:
                        break
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
            .signInWithAppleButtonStyle(
                colorScheme == .dark ? .white : .black
            )
            .frame(height: 50)
            .cornerRadius(15)
            .padding()
            
        }
        
    }
    
    
}

struct SignInApple_Previews: PreviewProvider {
    static var previews: some View {
        SignInApple()
    }
}
