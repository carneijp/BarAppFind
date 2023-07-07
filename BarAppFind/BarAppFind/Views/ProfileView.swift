//
//  Profile.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var cloud: CloudKitCRUD
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
    @State private var editProfile: Bool = false
    @State private var editPasswords: Bool = false
    @State private var showReportView: Bool = false
    
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
                            Spacer()
                            Text("Faça seu login")
                            Spacer()
                        }
                        .padding(12)
                        .background(.white)
                        .cornerRadius(30)
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
                        VStack {
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
                        .padding(.bottom, 100)
                    }
                    
                    // Conteúdo Tab. 2 - Editar Perfil
                case .profileEdit:
                    ScrollView {
                        VStack(alignment: .leading){
                            Text("Detalhes da conta")
                                .font(.system(size: 18))
                                .foregroundColor(.secondary)
                                .padding(.bottom, 17)
                            HStack{
                                Text(cloud.client?.firstName ?? "Nome")
                                    .font(.system(size: 18))
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            .padding(.all)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .padding(.bottom, 10)
                            
                            HStack{
                                Text(cloud.client?.lastName ?? "Sobrenome")
                                    .font(.system(size: 18))
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            .padding(.all)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .padding(.bottom, 10)
                            
                            HStack{
                                Text(cloud.client?.email ?? "Email")
                                    .font(.system(size: 18))
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            .padding(.all)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .padding(.bottom, 10)
                            
                            HStack{
                                Spacer()
                                Button(){
                                    if cloud.client != nil{
                                        editProfile = true
                                    }else {
                                        isPresented = true
                                    }
                                } label: {
                                    Text("Alterar dados")
                                        .foregroundColor(Color("white"))
                                        .frame(width: 178, height: 53)
                                        .background(Color("gray1"))
                                }
                                .cornerRadius(10)
                            }
                            
                            Text("Segurança")
                                .font(.system(size: 18))
                                .foregroundColor(.secondary)
                                .padding(.top, 30)
                                .padding(.bottom, 17)
                            if let client = cloud.client {
                                if client.userID == ""{
                                    HStack{
                                        Text("Senhas")
                                            .font(.system(size: 18))
                                            .foregroundColor(.secondary)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                    .padding(.all)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 2)
                                    .padding(.bottom, 10)
                                    .onTapGesture {
                                        editPasswords = true
                                    }
                                }
                            }
                            
                            Button {
                                self.showReportView = true
                            } label: {
                                HStack{
                                    Text("Reportar Problema")
                                        .font(.system(size: 18))
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .padding(.all)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                                .padding(.bottom, 10)
                            }
                            
                            if cloud.client != nil {
                                Button {
                                    cloud.client = nil
                                    UserDefaults.standard.set("", forKey: "UserID")
                                    UserDefaults.standard.set("", forKey: "Password")
                                    UserDefaults.standard.set("", forKey: "Email")
                                    
                                } label: {
                                    Text("Sair da conta")
                                        .padding(.all)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 2)
                                        .padding(.bottom, 10)
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 100)
                        .padding(.top, 30)
                    }
                }
                
                // MARK: - Final da View
                Spacer()
            }
            .padding(.top, 100)
            
            // Faz aparecer a tela de login de usuário
            .sheet(isPresented: $showSignIn) {
                SignInComponent()
            }
            .sheet(isPresented: $editProfile){
                if let client = cloud.client {
                    EditProfileComponent(firstName: client.firstName, lastName: client.lastName, email: client.email)
                }
            }
            .sheet(isPresented: $editPasswords){
                EditPasswordComponent()
            }
            .sheet(isPresented: $showReportView) {
                ReportComponent()
                    .environmentObject(cloud)
            }
            
            // Pop Up De "Login Necessário"
            LoginAlertComponent(title: "Login Necessário", description: "Para acessar as suas conquistas e os detalhes da sua conta, realize o login.", isShow: $isPresented)
            
            // PopUp de Primeira Conquista
            FirstConquestComponent(isShow: $showFirstConquest)
            
            ConquestModalComponent(showMedalConquest: $showMedalConquest, medalName: $medalName)
            
        }
        .onAppear() {
            if let primeiroLogin = UserDefaults.standard.string(forKey: "PrimeiroLogin"), primeiroLogin != ""{
            }else{
                self.showFirstConquest = true
                UserDefaults.standard.set("True", forKey: "PrimeiroLogin")
            }
        }
    }
}
