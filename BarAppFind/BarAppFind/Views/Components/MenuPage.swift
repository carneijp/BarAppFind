//
//  MenuPage.swift
//  Onde
//
//  Created by Joao Paulo Carneiro on 07/07/23.
//
import SwiftUI
import Foundation


struct MenuPage: View {
    @EnvironmentObject var cloud: CloudKitCRUD
    var barName: String
    var body: some View {
        VStack() {
//            Spacer()
            Image("erro404")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .padding(.vertical)
            Text("Desculpe, infelizmente esta Funcionalidade,")
                .foregroundColor(.purple)
            Text(" ainda não está disponivel.")
                .foregroundColor(.purple)
//            Spacer()
        }
        .padding(.top)
        .onAppear{
            cloud.addInterestToMenu(barName: barName)
        }
     
    }
}
