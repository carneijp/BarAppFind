//
//  Profile.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var cloud: CloudKitCRUD
    // Tab Bar do Perfil -> Padrão: Minhas Conquistas
    @State private var topProfileChoice: ChoiceProfile = .myConquests
    @State private var isMyConquests: Bool = true
    @State private var isProfileEdit: Bool = false
    @State private var isPresented: Bool = false
    @State private var showSignIn: Bool = false
    @State private var showModalConquest: Bool = false
    @State private var arrowDirection: ArrowDirection = .up
    
    // Opções da Tab Bar
    enum ChoiceProfile {
        case myConquests, profileEdit
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                
                // MARK: - Header
                Text("Fala, \(cloud.client?.firstName ?? "barzeiro")! 🤪🤟")
                    .bold()
                    .font(.system(size: 26))
                    .padding(.bottom, 30)
                
                
                // Botão de Fazer Login
                if cloud.client == nil {
                    Button {
                        showSignIn = true
                    } label: {
                        HStack {
                            Text("Fazer Login")
                        }
                        .padding(.all)
                        .frame(width: UIScreen.main.bounds.width - 180)
                        .background()
                        .cornerRadius(8)
                        .shadow(color: .primary.opacity(0.1), radius: 5, x: 0, y: 4)
                    }
                    .foregroundColor(.primary)
                    .padding(.bottom, 40)
                }
                
                // MARK: - Tab Bar
                HStack {
                    
                    // Tab 1: Minhas Conquistas
                    Group {
                        if isMyConquests {
                            VStack(spacing: 4) {
                                Text("Minhas Conquistas")
                                    .foregroundColor(.primary)
                                    .font(.system(size: 14))
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.primary)
                            }
                            
                        } else {
                            VStack {
                                Text("Minhas Conquistas")
                                    .foregroundColor(.secondary)
                                    .font(.system(size: 14))
                                    .onTapGesture {
                                        self.topProfileChoice = .myConquests
                                        isMyConquests = true
                                        isProfileEdit = false
                                    }
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width/2)
                    .padding(.leading, 24)
                    
                    Spacer()
                    
                    // Tab 2: Editar Perfil
                    Group {
                        if isProfileEdit {
                            VStack(spacing: 4) {
                                Text("Editar Perfil")
                                    .font(.system(size: 14))
                                    .foregroundColor(.primary)
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.primary)
                            }
                            
                        } else {
                            VStack {
                                Text("Editar Perfil")
                                    .font(.system(size: 14))
                                    .foregroundColor(.secondary)
                                    .onTapGesture {
                                        self.topProfileChoice = .profileEdit
                                        isMyConquests = false
                                        isProfileEdit = true
                                    }
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width/2)
                    .padding(.trailing, 24)
                    
                }
                
                // MARK: - Conteúdo Tab Bar
                switch topProfileChoice {
                    
                // Conteúdo Tab. 1 - Minhas Conquistas
                case .myConquests:
                    ScrollView {
                        VStack(spacing: 32) {
                            Grid(horizontalSpacing: 18) {
                                GridRow {
                                    MedalComponent()
                                        .onTapGesture {
                                            showModalConquest = true
                                        }
                                        .iOSPopover(showModalConquest: $showModalConquest, arrowDirection: arrowDirection.direction) {
                                            ConquestModalComponent()
                                                .frame(width: UIScreen.main.bounds.width - 48, height: 130)
                                        }
                                    
                                    MedalComponent()
                                }
                            }
                            
                            Spacer()
                        }
                        .padding(.top, 32)
                        .padding(.horizontal, 24)
                    }
                
                // Conteúdo Tab. 2 - Editar Perfil
                case .profileEdit:
                    HStack {
                        Text("Detalhes da conta")
                            .font(.system(size: 16))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                        
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 30)
                    .background(.secondary.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.top, 24)
                    .padding(.horizontal, 24)
                }
                
                // MARK: - Final da View
                Spacer()
            }
            .padding(.top, 100)
            
            // Faz aparecer a tela de login de usuário
            .sheet(isPresented: $showSignIn) {
                SignInComponent()
            }
            
            // Pop Up De "Login Necessário"
            LoginAlertComponent(title: "Login Necessário", description: "Para acessar as suas conquistas e os detalhes da sua conta, realize o login.", isShow: $isPresented)
        }
        // Faz aparecer o Pop Up de Login Necessário
        .onAppear() {
            if cloud.client == nil {
                self.isPresented = true
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

// MARK: Popover Arrow Direction - Não mexer!
enum ArrowDirection: String,CaseIterable{
    case up = "Up"
    case down = "Down"
    case left = "Left"
    case right = "Right"
    
    var direction: UIPopoverArrowDirection{
        switch self {
        case .up:
            return .up
        case .down:
            return .down
        case .left:
            return .left
        case .right:
            return .right
        }
    }
}
