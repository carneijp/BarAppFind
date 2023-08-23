//
//  EditProfileComponent.swift
//  Onde
//
//  Created by Eduardo Pretto on 24/05/23.
//

import SwiftUI

struct EditProfileComponent: View {
    @EnvironmentObject private var cloud: Model
    @Environment(\.presentationMode) var presentation
    @Binding var firstName: String
    @Binding var lastName: String
    @State var isLoading: Bool = false
    @State var sucesso: Bool = false
    @State var todosOsCamposPreenchidos: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("Seus dados atuais: (Toque para alterar)")
                        .padding()
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .padding(.top, 12)
                        .padding(.horizontal, 24)
                    Spacer()
                }
                
                Group {
                    TextField("Nome", text: $firstName, axis: .vertical)
                    
                    TextField("Sobrenome", text: $lastName, axis: .vertical)
                }
                .lineLimit(1, reservesSpace: true)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("gray0").opacity(0.6)))
                .foregroundColor(.secondary)
                .padding(.horizontal, 24)
                
                if todosOsCamposPreenchidos {
                    Text("Todos os campos devem ser preenchidos com dados válidos.")
                        .foregroundColor(.red)
                        .font(.system(size: 12))
                        .padding(.top, 8)
                }

                Button {
                    isLoading = true
                    todosOsCamposPreenchidos = false
                    firstName = firstName.trimmingCharacters(in: .whitespaces)
                    lastName = lastName.trimmingCharacters(in: .whitespaces)
                    if(!firstName.isEmpty && !lastName.isEmpty){
                            if var cliente = cloud.client{
                                cliente.firstName = firstName
                                cliente.lastName = lastName
                                cliente = cliente.updateClient(newFirstName: firstName, newLastName: lastName)
                                cloud.updateUser(updatedUser: cliente) { _ in
                                    isLoading = false
                                    sucesso = true
                                }
                            }
                    }else {
                        isLoading = false
                        todosOsCamposPreenchidos = true
                    }
                    
                }label: {
                    Spacer()
                    Text("Salvar")
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                    Spacer()
                }
                .background(.white)
                .cornerRadius(24)
                .shadow(color: Color("gray6") ,radius: 3, x: 0, y: 2)
                .padding()
                Spacer()
            }
            if isLoading {
                LoadingViewModel()
                    .padding(.bottom, 130)
            }
        }
        .onChange(of: sucesso, perform: { newValue in
            presentation.wrappedValue.dismiss()
        })
        .navigationTitle("Alterar dados da conta")
    }
}
