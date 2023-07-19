//
//  SignInApple.swift
//  Onde
//
//  Created by Joao Paulo Carneiro on 24/05/23.
//

import SwiftUI
import AuthenticationServices

struct SignInApple: View {
    @EnvironmentObject var cloud: CloudKitCRUD
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("Email") var email: String = ""
    @AppStorage("FirstName") var firstName: String = ""
    @AppStorage("LastName") var lastName: String = ""
    @AppStorage("UserID") var userId: String = ""
    @State private var isLoading: Bool = false
    @Binding var loginSuccess: Bool
    
    var body: some View {
        ZStack{
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
                            
                            isLoading = true
                            cloud.addUserID(clients: Clients(email: self.email, firstName: self.firstName, lastName: self.lastName, userID: self.userId)) { result in
                                
                                cloud.validadeClientLoginWithApple(userID: self.userId) { result in
                                    isLoading = false
                                    loginSuccess = true
                                }
                            }
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
                    .black
                )
                .frame(height: 45)
                .cornerRadius(24)
            }
            if isLoading {
                LoadingViewModel()
                    .padding(.bottom, 130)
            }
        }
    }
}

//struct SignInApple_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInApple()
//    }
//}
