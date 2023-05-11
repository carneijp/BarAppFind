//
//  Profile.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var cloud: CloudKitCRUD
    @State var topProfileChoice: ChoiceProfile = .myConquests
    @State var isMyConquests: Bool = true
    @State var isProfileEdit: Bool = false
    
    enum ChoiceProfile {
        case myConquests, profileEdit
    }
    
    var body: some View {
        
        VStack {
            
            // MARK: - Header
            Text("Fala, barzeiro! 🤪🤟")
                .bold()
                .font(.system(size: 26))
                .padding(.bottom, 40)
            
            Text("Cadastre-se aqui")
                .padding(.bottom, 40)
            
            
            
            // MARK: - Tab Bar
            GeometryReader { geo in
                HStack {
                    Group {
                        if isMyConquests {
                            VStack(spacing: 4) {
                                Text("Minhas Conquistas")
                                    .foregroundColor(.primary)
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.primary)
                            }
                            .padding(.leading, 14)
                            .frame(width: geo.frame(in: .global).width/2)
                            
                        } else {
                            VStack {
                                Text("Minhas Conquistas")
                                    .foregroundColor(.secondary)
                                    .onTapGesture {
                                        self.topProfileChoice = .myConquests
                                        isMyConquests = true
                                        isProfileEdit = false
                                    }
                            }
                            .padding(.leading, 14)
                            .frame(width: geo.frame(in: .global).width/2)
                        }
                    }
                    
                    Spacer()
                    
                    Group {
                        if isProfileEdit {
                            VStack(spacing: 4) {
                                Text("Editar Perfil")
                                    .foregroundColor(.primary)
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.primary)
                            }
                            .padding(.horizontal, 24)
                            .frame(width: geo.frame(in: .global).width/2)

                        } else {
                            VStack {
                                Text("Editar Perfil")
                                    .foregroundColor(.secondary)
                                    .onTapGesture {
                                        self.topProfileChoice = .profileEdit
                                        isMyConquests = false
                                        isProfileEdit = true
                                    }
                            }
                            .padding(.horizontal, 24)
                            .frame(width: geo.frame(in: .global).width/2)

                        }
                    }
                }
            }
        }
        .padding(.top, 40)
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
