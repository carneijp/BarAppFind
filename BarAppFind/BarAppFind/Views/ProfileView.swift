//
//  Profile.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var cloud: Model
    @Environment(\.dynamicTypeSize) var size
    
    @State private var topProfileChoice: ChoiceProfile = .myConquests
    @State private var isMyConquests: Bool = true
    @State private var isProfileEdit: Bool = false
    @State private var isPresented: Bool = false
//    @State private var showSignIn: Bool = false
    @State private var showModalConquest: Bool = false
    @State private var scale: CGFloat = 1.0
    @State private var showFirstConquest: Bool = false
    @State private var showMedalConquest: Bool = false
    @State private var medalName: String = ""
    @State private var editProfile: Bool = false
    @State private var editPasswords: Bool = false
    @State private var showReportView: Bool = false
    @State private var showAlertLeaveAccount: Bool = false
    @State private var showFirstAlertDeleteAccount: Bool = false
    @State private var showSecondAlertDeleteAccount: Bool = false
    @Namespace private var nameSpace
    @State var clientEmail: String = "Email"
    @State var clientName: String = "Nome"
    @State var clientSurname: String = "Sobrenome"
    @State var clientWelcome: String = "Cliente"
    
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
                Text("Olá, \(clientWelcome)!")
                    .bold()
                    .font(.title)
                    .padding(.bottom, 30)
                    .accessibilityLabel(Text("Olá, \(clientWelcome). Titulo."))
                
                // MARK: - Tab Bar
                HStack {
                    
                    // Tab 1: Minhas Conquistas
                    Group {
                        if isMyConquests {
                            VStack(spacing: 4) {
                                Text("Minhas Conquistas")
                                    .foregroundColor(.primary)
                                    .font(.subheadline)
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.primary)
                                    .matchedGeometryEffect(id: "SelectedTab", in: nameSpace)
                            }
                            .padding(.leading, 24)
                            
                            
                        } else {
                            VStack {
                                Text("Minhas Conquistas")
                                    .foregroundColor(.secondary)
                                    .font(.subheadline)
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            self.topProfileChoice = .myConquests
                                            isMyConquests = true
                                            isProfileEdit = false
                                        }
                                    }
                            }
                            .padding(.leading, 24)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width/2)
                    .accessibilityLabel(Text("Minhas Conquistas. Botão."))
                    
                    Spacer()
                    
                    // Tab 2: Editar Perfil
                    Group {
                        if isProfileEdit {
                            VStack(spacing: 4) {
                                Text("Editar Perfil")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.primary)
                                    .matchedGeometryEffect(id: "SelectedTab", in: nameSpace)
                            }
                            .padding(.trailing, 24)
                            
                        } else {
                            VStack {
                                Text("Editar Perfil")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            self.topProfileChoice = .profileEdit
                                            isMyConquests = false
                                            isProfileEdit = true
                                        }
                                    }
                            }
                            .padding(.trailing, 24)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width/2)
                    .accessibilityLabel(Text("Editar perfil. Botão."))
                }
                
                
                // MARK: - Conteúdo Tab Bar
                switch topProfileChoice {
                    
                    // Conteúdo Tab. 1 - Minhas Conquistas
                case .myConquests:
                    ScrollView {
                        VStack {
                            if size >= .accessibility2 {
                                LazyVStack {
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
                            } else {
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
                        }
                        .padding(.bottom, 100)
                    }
                    
                    // Conteúdo Tab. 2 - Editar Perfil
                case .profileEdit:
                    ScrollView {
                        VStack(alignment: .leading){
                            Text("Detalhes da conta")
                                .font(.body)
                                .foregroundColor(.primary)
                                .padding(.bottom, 17)
                            
                            HStack {
                                Text(clientName)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
//                            .frame(height: 42)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color("gray8"))
                            .cornerRadius(6)
                            .padding(.bottom, 10)
                            
                            HStack{
                                Text(clientSurname)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
//                            .frame(height: 42)
                            .padding(.vertical, 8)
                            .padding(.horizontal)
                            .background(Color("gray8"))
                            .cornerRadius(6)
                            .padding(.bottom, 10)
                            
                            Button {
                                editProfile = true
                            } label: {
                                HStack{
                                    Spacer()
                                    Text("Alterar dados")
                                        .font(.body)
                                        .padding(.vertical, 12)
                                        .padding(.horizontal)
                                    Spacer()
                                }
                                .background(.white)
                                .cornerRadius(24)
                                .shadow(color: Color("gray6") ,radius: 3, x: 0, y: 2)
                            }
                            
                            Text("Segurança")
                                .font(.body)
                                .foregroundColor(.primary)
                                .padding(.top, 30)
                                .padding(.bottom, 17)
                            
                            if let client = cloud.client {
                                if client.userID == ""{
                                    HStack{
                                        Text("Senhas")
                                            .font(.body)
                                            .foregroundColor(.secondary)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.all, 12)
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
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.secondary)
                                }
                                .padding(.all, 12)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                                .padding(.bottom, 10)
                            }
                            
                            if cloud.client != nil {
                                if UserDefaults.standard.string(forKey: "Deletion") == "Requested"{
                                    Button {
                                        showSecondAlertDeleteAccount = true
                                    } label: {
                                        Text("Deletar conta")
                                            .font(.body)
                                            .foregroundColor(.secondary)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.all, 12)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 2)
                                    .padding(.vertical, 10)
                                    .alert(isPresented: $showSecondAlertDeleteAccount) {
                                        Alert(title: Text("Aviso"), message: Text("Sua solicitação Já está sendo processada."), dismissButton: .cancel())
                                    }
                                }else {
                                    Button {
                                        showFirstAlertDeleteAccount = true
                                    } label: {
                                        Text("Deletar conta")
                                            .font(.body)
                                            .foregroundColor(.secondary)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.all, 12)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 2)
                                    .padding(.vertical, 10)
                                    .alert(isPresented: $showFirstAlertDeleteAccount) {
                                        Alert(title: Text("Confirmação Necessária"), message: Text("Você deseja realmente deletar a sua conta?\nSua conta será deletada em até 72 horas."), primaryButton: .destructive(Text("Cancelar")), secondaryButton: .default(Text("Confirmar"), action: {
                                            UserDefaults.standard.set("Requested", forKey: "Deletion")
                                        }))
                                    }
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
            
//            .navigationDestination(isPresented: $showSignIn) {
//                SignInComponent()
//                    .toolbarRole(.editor)
//            }
            
            .navigationDestination(isPresented: $editProfile){
                EditProfileComponent(firstName: $clientName, lastName: $clientSurname)
                    .toolbarRole(.editor)
            }
            
            .navigationDestination(isPresented: $showReportView) {
                ReportComponent()
                    .toolbarRole(.editor)
                    .environmentObject(cloud)
            }
            
            // Pop Up De "Login Necessário"
//            LoginAlertComponent(title: "Login Necessário", description: "Para acessar as suas conquistas e os detalhes da sua conta, realize o login.", isShow: $isPresented)
            
            // PopUp de Primeira Conquista
            FirstConquestComponent(isShow: $showFirstConquest)
            
            ConquestModalComponent(showMedalConquest: $showMedalConquest, medalName: $medalName)
            
        }
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            guard let client = cloud.client else { return }
            self.clientName = client.firstName
            self.clientSurname = client.lastName
            self.clientWelcome = client.firstName
            if let primeiroLogin = UserDefaults.standard.string(forKey: "PrimeiroLogin"), primeiroLogin != ""{
            }else{
                self.showFirstConquest = true
                UserDefaults.standard.set("True", forKey: "PrimeiroLogin")
            }
        }
    }
}

