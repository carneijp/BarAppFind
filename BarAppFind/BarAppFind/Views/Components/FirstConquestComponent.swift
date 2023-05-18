//
//  FirstConquestComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 18/05/23.
//

import SwiftUI

struct FirstConquestComponent: View {
    @Binding var isShow: Bool
    
    var body: some View {
        VStack(spacing: 2) {
            Text("Parabéns!")
                .font(.system(size: 28))
                .bold()
                .foregroundColor(.white)
                .padding(.bottom, 6)
            
            Image("Primeiro Acesso")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Text("Pensando Onde ir hoje? O início de sua jornada pelos bares de Porto Alegre começa aqui!")
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.bottom)
            
            Button {
                self.isShow = false
            } label: {
                HStack {
                    Spacer()
                    Text("Vamos lá!")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                    Spacer()
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 24)
            .background(.white)
            .cornerRadius(10)
            .shadow(radius: 1, y: 2)

        }
        .frame(width: UIScreen.main.bounds.width - 140)
        .padding([.vertical, .horizontal], 30)
        .background(LinearGradient(gradient: Gradient(colors: [Color("darkBlueGradient"), Color("softBlueGradient")]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(40)
        .animation(.spring())
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 40)
        .background(.secondary.opacity(0.01))
        .offset(y: isShow ? -10 : UIScreen.main.bounds.height)
        .onTapGesture {
            isShow = false
        }
        
    }
}

struct FirstConquestComponent_Previews: PreviewProvider {
    static var previews: some View {
        FirstConquestComponent(isShow: .constant(true))
    }
}
