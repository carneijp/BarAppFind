//
//  BarPageSobreView.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 11/05/23.
//

import SwiftUI

struct BarPageSobreView: View {
    //Criar icone com fundo cinza a partir de uma imagem do sistema(compartilhar)
    @ViewBuilder
    func createSystemIcon(imageName: String, text: String)-> some View {
        VStack {
            ZStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 31)
                    .padding(10)
                    .background(Color.gray)
                    .cornerRadius(10)
            }
            Text(text)
                .font(.system(size: 10))
        }
    }
    
    //Criar icone com fundo cinza a partir de uma imagem qualquer(instagram)
    @ViewBuilder
    func createCustomIcon(imageName: String, text: String)-> some View {
        VStack {
            ZStack {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 35, height: 31)
                    .padding(10)
                    .background(Color.gray)
                    .cornerRadius(10)
    //                .background(Color.green)
            }
            Text(text)
                .font(.system(size: 10))
            
        }
    }
    
    //Criar icone de ambiente a partir de uma imagem do sistema (climatizado)
    @ViewBuilder
    func createAmbientIconSystem(ambientText: String, imageName: String) -> some View{
        VStack{
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 31)
            
            Text(ambientText)
                .font(.system(size: 6))
        }
    }
    
    //Criar icone de ambiente a partir de uma imagem qualquer (estacionamento)
    @ViewBuilder
    func createAmbientIconCustom(ambientText: String, imageName: String) -> some View{
        VStack{
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 31)
            
            Text(ambientText)
                .font(.system(size: 6))
        }
    }
    
    //@EnvironmentObject var cloud: CloudKitCRUD
    @State var bar: Bar
    
    var body: some View {
        VStack {
            HStack{
                Text(bar.name)
                    .font(.title2)
                    .bold()
                    .padding(.trailing)
                
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15)
                
                Text(String(format: "%.1f", bar.grade))
                    .font(.system(size: 14))
                
                Spacer()
                Image(systemName: "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15)
                    .padding(.trailing, 15)
                
            }
            .padding(.top)
            
            
            
            HStack {
                Text(bar.description)
                    .font(.system(size: 16))
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            .padding(.bottom)
            
            
            HStack{
                createCustomIcon(imageName: "Instagram", text: "Instagram")
                
                
                createSystemIcon(imageName: "square.and.arrow.up",text: "Compartilhar")
                
                Spacer()
            }
            .padding(.bottom)
            
            HStack {
                Text("Boa escolha para ...")
                    .font(.system(size: 14))
                Spacer()
            }
            
            HStack{
                ForEach(bar.mood, id:\.self){ mood in
                        MoodComponent(mood: mood)
                    }
            }
            
            HStack {
                Text("Sobre o ambiente")
                    .font(.system(size:20))
                    .bold()
                Spacer()
            }
            .padding(.vertical)
            
            HStack{
                createAmbientIconCustom(ambientText: "Estacionamento", imageName: "Estacionamento")
                createAmbientIconSystem(ambientText: "Climatizado", imageName: "snowflake")
                Spacer()
            }
            
        }
        .padding(.horizontal)
    }
}

struct BarPageSobreView_Previews: PreviewProvider {
    static var previews: some View {
        BarPageSobreView(bar: Bar(name: "a", description: "a", mood: ["a"], grade: 0.0, latitude: 0.0, longitude: 0.0, operatinhours: ["f"], endereco: "a", regiao: "a", caracteristicas: ["f"]))
    }
}
