//
//  ConquestModalComponent.swift
//  BarAppFind
//
//  Created by Guilherme Borges Cavali on 12/05/23.
//

import SwiftUI

struct ConquestModalComponent: View {
    @Binding var showMedalConquest: Bool
    @Binding var medalName: String
    
    var body: some View {
        
        VStack {
                if medalName == conquestMedals[0] {
                    HStack(spacing: 14) {
                        Image(conquestMedals[0])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 70)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(conquestMedals[0])
                                .font(.system(size: 16))
                                .bold()
                            
                            Text(medalDescriptions[0])
                                .font(.system(size: 14))
                        }
                    }
                    .padding(.all, 32)
                    .background()
                    .cornerRadius(12)
                    .shadow(color: .primary.opacity(0.1), radius: 5, x: 0, y: 4)
                    .frame(width: UIScreen.main.bounds.width - 48)
                } else if medalName == conquestMedals[1] {
                    HStack(spacing: 14) {
                        Image(conquestMedals[1])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 70)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(conquestMedals[1])
                                .font(.system(size: 16))
                                .bold()
                            
                            Text(medalDescriptions[1])
                                .font(.system(size: 14))
                        }
                    }
                    .padding(.all, 32)
                    .background()
                    .cornerRadius(12)
                    .shadow(color: .primary.opacity(0.1), radius: 5, x: 0, y: 4)
                    .frame(width: UIScreen.main.bounds.width - 48)
                } else if medalName == conquestMedals[2] {
                    HStack(spacing: 14) {
                        Image(conquestMedals[2])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 70)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(conquestMedals[2])
                                .font(.system(size: 16))
                                .bold()
                            
                            Text(medalDescriptions[2])
                                .font(.system(size: 14))
                        }
                    }
                    .padding(.all, 32)
                    .background()
                    .cornerRadius(12)
                    .shadow(color: .primary.opacity(0.1), radius: 5, x: 0, y: 4)
                    .frame(width: UIScreen.main.bounds.width - 48)
                } else {
                    HStack(spacing: 14) {
                        Image(conquestMedals[3])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 70)

                        VStack(alignment: .leading, spacing: 8) {
                            Text(medalName)
                                .font(.system(size: 16))
                                .bold()
                            
                            Text("Você ainda não atingiu este nível.")
                                .font(.system(size: 14))
                        }
                    }
                    .padding(.all, 32)
                    .background()
                    .cornerRadius(12)
                    .shadow(color: .primary.opacity(0.1), radius: 5, x: 0, y: 4)
                    .frame(width: UIScreen.main.bounds.width - 48)
                }
        }
//        .animation(.spring())
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 40)
        .background(.secondary.opacity(0.01))
        .offset(y: showMedalConquest ? -10 : UIScreen.main.bounds.height)
        .onTapGesture {
            self.showMedalConquest = false
        }
    }
}

//struct ConquestModalComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        ConquestModalComponent(showMedalConquest: .constant(true))
//    }
//}
