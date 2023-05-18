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
    @State private var scale: CGFloat = 1.0
    @State private var showFirstConquest: Bool = false
    @State private var showMedalConquest: Bool = false
    @State private var medalName: String = ""

//    @State private var showAnimation: Bool = true
    
    // Opções da Tab Bar
    enum ChoiceProfile {
        case myConquests, profileEdit
    }
    
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        
        ZStack {
            VStack {
                
                // MARK: - Header
                Text("Olá, \(cloud.client?.firstName ?? "cliente")!")
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
                            Spacer()
                            Image(systemName: "chevron.up")
                        }
                        .padding(.all)
                        .background(Color("Fofoca3"))
                        .cornerRadius(8)
                        .shadow(color: .primary.opacity(0.1), radius: 5, x: 0, y: 4)
                    }
                    .frame(width: UIScreen.main.bounds.width - 28)
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
                            .padding(.leading, 24)
                            
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
                            .padding(.leading, 24)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width/2)
                    
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
                            .padding(.trailing, 24)
                            
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
                            .padding(.trailing, 24)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width/2)
                }
                
                // MARK: - Conteúdo Tab Bar
                switch topProfileChoice {
                    
                    // Conteúdo Tab. 1 - Minhas Conquistas
                case .myConquests:
                    ScrollView {
                        
                        // Primeira conquista do App
                        HStack (spacing: 20) {
                            Image("Primeiro Acesso")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color("gray1"))
                                .shadow(radius: 2, y: 2)
                    
                            Text("Primeiro Acesso")
                                .font(.system(size: 16))
                                .bold()
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("white"))
                        }
                        .padding(.vertical, 30)
                        .padding(.horizontal, 10)
                        .frame(width: UIScreen.main.bounds.width - 48 ,height: 90)
                        .background(Color("roxo"))
                        .cornerRadius(12)
                        .shadow(radius: 2, y: 2)
                        .padding(.top, 20)
                        .onTapGesture {
                            showFirstConquest = true
                        }

                        LazyVGrid(columns: columns, spacing: 18) {
                            ForEach(conquestMedals, id: \.self) { medal in
                                if cloud.client == nil {
                                    MedalComponent(medalName: medal)
                                        .foregroundColor(.gray)
                                        .onTapGesture {
                                            showMedalConquest = true
                                            medalName = medal
                                        }
                                } else {
                                    MedalComponent(medalName: medal)
                                        .onTapGesture {
                                            showMedalConquest = true
                                            medalName = medal
                                        }
                                }
                            }
                        }
                        .padding(.top, 16)
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
            
            // PopUp de Primeira Conquista
            FirstConquestComponent(isShow: $showFirstConquest)
            
            ConquestModalComponent(showMedalConquest: $showMedalConquest, medalName: $medalName)
            
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
