//
//  CustomAlertComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 11/05/23.
//

import SwiftUI

struct ReviewAlertComponent: View {
    var title: String
    var description: String
    @Binding var isShow: Bool
//    @State private var showReviewError: Bool = false
    
    var body: some View {
        VStack(spacing: 24) {
            
            // Textos
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: "exclamationmark.circle.fill")
                    .imageScale(.large)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(self.title)
                        .font(.system(size: 16))
                        .bold()
                    
                    Text(self.description)
                        .font(.system(size: 14))
                }
            }
            .padding(.trailing, 10)
            
            // Botões do PopUp
            HStack {
                Button {
                    self.isShow = false
                } label: {
                    Text("Ok, entendi!")
                        .font(.system(size: 14))
                        .foregroundColor(Color("white"))
                        .bold()
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 24)
                .background(Color("gray7"))
                .cornerRadius(12)
                .shadow(radius: 2, y: 2)
            }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 30)
        .frame(width: UIScreen.main.bounds.width - 48)
        .background(Color("white"))
        .cornerRadius(12)
        .shadow(color: .primary.opacity(0.1), radius: 5, x: 0, y: 4)
        .animation(.spring())
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 40)
        .background(.secondary.opacity(0.01))
        .offset(y: isShow ? -10 : UIScreen.main.bounds.height)
//        .sheet(isPresented: $showReviewError) {
//            SignInComponent()
//        }
        .onTapGesture {
            self.isShow = false
        }
    }
}

struct ReviewAlertComponent_Previews: PreviewProvider {
    static var previews: some View {
        ReviewAlertComponent(title: "Avaliação Necessária!", description: "Para prosseguir, é necessário atribuir pelo menos uma estrela à avaliação deste bar.", isShow: .constant(true) )
    }
}
