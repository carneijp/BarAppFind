//
//  BarPageView.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 04/05/23.
//

import SwiftUI

struct BarPageView: View {
    enum ChoiceBar {
        case barName, info, review
    }
    
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
    //                .background(Color.green)
            }
            Text(text)
                .font(.system(size: 10))
        }
    }
    
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
//        .frame(width: 35, height: 31)
//        .padding(20)
//        .background(Color.gray)
//        .cornerRadius(20)
    }
    
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
    
    @ViewBuilder
    func createMood(mood: String)-> some View {
        ZStack {
            Text(mood)
                .font(.system(size: 14))
        }
        .frame(width: 106, height: 79)
        .padding(20)
        .background(Color.gray)
        .cornerRadius(20)
    }
    
    
    @State var topBarChoice: ChoiceBar = .barName
    
    @State var isBarName: Bool = true
    @State var isInfo: Bool = false
    @State var isReview: Bool = false
    
    var body: some View {
        VStack{
            Image("bakground")
                .resizable()
                .scaledToFit()
                .padding(.bottom, 10)
            
            //tabBar
            HStack{
                Group{
                    if isBarName{
                        Text("Sobre o lugar")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .underline()
                            .bold()
                    }else{
                        Text("Sobre o lugar")
                            .font(.system(size: 14))

                            .foregroundColor(.gray)
                            .onTapGesture {
                                self.topBarChoice = .barName
                                isBarName = true
                                isInfo = false
                                isReview = false
                            }
                    }
                }
                
                Group{
                    if isInfo{
                        Text("Informações")
                            .font(.system(size: 14))
                            .padding(.leading, 40)
                            .foregroundColor(.black)
                            .underline()
                            .bold()
                    }else{
                        Text("Informações")
                            .font(.system(size: 14))
                            .padding(.leading, 40)
                            .foregroundColor(.gray)
                            .onTapGesture {
                                self.topBarChoice = .info
                                isBarName = false
                                isInfo = true
                                isReview = false
                            }
                    }
                }
                Group{
                    if isReview{
                        Text("Avaliações")
                            .padding(.leading, 40)
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .underline()
                            .bold()
                    }else{
                        Text("Avaliações")
                            .font(.system(size: 14))
                            .padding(.leading, 40)
                            .foregroundColor(.gray)
                            .onTapGesture {
                                self.topBarChoice = .info
                                isBarName = false
                                isInfo = false
                                isReview = true
                            }
                    }
                }
                
            }
//            Divider()
            switch topBarChoice{
                case .barName:
                    VStack {
                        HStack{
                            Text("Deusa Bar")
                                .font(.title2)
                                .bold()
                                .padding(.trailing)
                            
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15)
                            
                            Text("4,6")
                                .font(.system(size: 14))
                            
                            Spacer()
                            Image(systemName: "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15)
                                .padding(.trailing, 15)
                            
                        }
                        .padding(.vertical)
                        
  
                        
                        HStack {
                            Text("Bar com ótimos drinks, atuando junto aos clientes desde 2015. Contamos com diversas opções de drinks e petiscos.")
                                .font(.system(size: 16))
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                        }
                        .padding(.vertical)
                            
                        
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
                            
                            MoodComponent(mood: "mood")
                            MoodComponent(mood: "mood")
                            MoodComponent(mood: "mood")
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
                case .info:
                    VStack{
                        Text("aa")}
                        .padding(.horizontal)
                case .review:
                    Text("aa")
                    
   
            }

            
            
            
            Spacer()
        }
        .navigationBarTitle("Deusa Bar", displayMode: .inline)
    }
}

struct BarPageView_Previews: PreviewProvider {
    static var previews: some View {
        BarPageView()
    }
}
