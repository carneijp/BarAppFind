////
////  EditProfileComponent.swift
////  Onde
////
////  Created by Eduardo Pretto on 24/05/23.
////
//
//import SwiftUI
//
//struct EditProfileComponent: View {
//    @EnvironmentObject private var cloud: Model
//    @Environment(\.presentationMode) var presentation
//    //    var cliente: Clients
//    @Binding var firstName: String
//    @Binding var lastName: String
//    @Binding var email: String
//    @State var isLoading: Bool = false
//    @State var emailAlreadyInUse: Bool = false
//    @State var sucesso: Bool = false
//    @State var emailInvalido: Bool = false
//    @State var todosOsCamposPreenchidos: Bool = false
//    
//    var body: some View {
//        ZStack{
//            VStack{
//                HStack{
//                    Text("Seus dados atuais: (Toque para alterar)")
//                        .padding()
//                        .font(.system(size: 14))
//                        .foregroundColor(.secondary)
//                        .padding(.top, 12)
//                        .padding(.horizontal, 24)
//                    Spacer()
//                }
//                
//                Group {
//                    TextField("Nome", text: $firstName, axis: .vertical)
//                    
//                    TextField("Sobrenome", text: $lastName, axis: .vertical)
//                    
//                    TextField("E-mail", text: $email, axis: .vertical)
//                }
//                .lineLimit(1, reservesSpace: true)
//                .padding()
//                .background(RoundedRectangle(cornerRadius: 10).fill(Color("gray0").opacity(0.6)))
//                .foregroundColor(.secondary)
//                .padding(.horizontal, 24)
//                
//                if emailAlreadyInUse {
//                    Text("O email de interesse já está sendo utilizado.")
//                        .foregroundColor(.red)
//                        .font(.system(size: 12))
//                        .padding(.top, 8)
//                }
//                
//                if todosOsCamposPreenchidos {
//                    Text("Todos os campos devem ser preenchidos com dados válidos.")
//                        .foregroundColor(.red)
//                        .font(.system(size: 12))
//                        .padding(.top, 8)
//                }
//                
//                if emailInvalido {
//                    Text("Deve ser informado um email valido.")
//                        .foregroundColor(.red)
//                        .font(.system(size: 12))
//                        .padding(.top, 8)
//                }
//                
//                Button {
//                    isLoading = true
//                    emailAlreadyInUse = false
//                    emailInvalido = false
//                    todosOsCamposPreenchidos = false
//                    email = email.trimmingCharacters(in: .whitespaces)
//                    firstName = firstName.trimmingCharacters(in: .whitespaces)
//                    lastName = lastName.trimmingCharacters(in: .whitespaces)
//                    if(!email.isEmpty && !firstName.isEmpty && !lastName.isEmpty){
//                        if(email.contains("@") && email.contains(".")){
//                            if let cliente = cloud.client{
//                                let emailAntigo: String = cliente.email
//                                cliente.firstName = firstName
//                                cliente.lastName = lastName
//                                cliente.email = email
//                                cloud.changeUserInfo(client: cliente, emailAntigo: emailAntigo){ result in
//                                    if result{
//                                        isLoading = false
//                                        sucesso = true
//                                        DispatchQueue.main.async {
//                                            UserDefaults.standard.set(cliente.email, forKey: "Email")
//                                        }
//                                    }else {
//                                        isLoading = false
//                                        emailAlreadyInUse = true
//                                        print("Email já existe, ou falha na comunicação")
//                                    }
//                                    
//                                }
//                            }
//                        }else{
//                            isLoading = false
//                            emailInvalido = true
//                        }
//                    }else {
//                        isLoading = false
//                        todosOsCamposPreenchidos = true
//                    }
//                    
//                }label: {
//                    Spacer()
//                    Text("Salvar")
//                        .padding(.vertical, 12)
//                        .padding(.horizontal)
//                    Spacer()
//                }
//                .background(.white)
//                .cornerRadius(24)
//                .shadow(color: Color("gray6") ,radius: 3, x: 0, y: 2)
//                .padding()
//                Spacer()
//            }
//            if isLoading {
//                LoadingViewModel()
//                    .padding(.bottom, 130)
//            }
//        }
//        .onChange(of: sucesso, perform: { newValue in
//            presentation.wrappedValue.dismiss()
//        })
//        .navigationTitle("Alterar dados da conta")
//    }
//}
//
////struct EditProfileComponent_Previews: PreviewProvider {
////    static var previews: some View {
////        EditProfileComponent()
////    }
////}
