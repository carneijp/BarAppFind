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
    func createSystemIcon(imageName: String)-> some View {
        ZStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color.green)
        }
        .frame(width: 35, height: 31)
        .padding(20)
        .background(Color.gray)
        .cornerRadius(20)
    }
    
    @ViewBuilder
    func createCustomIcon(imageName: String)-> some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color.green)
        }
        .frame(width: 35, height: 31)
        .padding(20)
        .background(Color.gray)
        .cornerRadius(20)
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
                        Text("Deusa Bar")
                            .foregroundColor(.black)
                            .underline()
                            .bold()
                    }else{
                        Text("Deusa Bar")
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
                            .padding(.leading, 40)
                            .foregroundColor(.black)
                            .underline()
                            .bold()
                    }else{
                        Text("Informações")
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
                        Text("Reviews")
                            .padding(.leading, 40)
                            .foregroundColor(.black)
                            .underline()
                            .bold()
                    }else{
                        Text("Reviews")
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
                    VStack{
                        HStack{
                            Text("Deusa Bar")
                                .font(.title2)
                                .bold()
                            
                            Text("•")
                                .foregroundColor(.gray)
                            
                            Text("3km")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Image(systemName: "dollarsign")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 7)
                            Image(systemName: "dollarsign")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 7)
                                .padding(.leading, -5)
                            
                            Spacer()
                            
                            Image(systemName: "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25)
                        }
                        
                        HStack{
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15)
                            
                            Text("4,6")
                                .font(.system(size: 14))
                            
                            Text("•")
                                .foregroundColor(.gray)
                            
                            Text("aberto - 8h às 20h")
                                .font(.system(size: 14))
                            
                            Spacer()
                        }
                        .padding(.top, -15)
                        //            .background(.gray)
                        
                        Text("Bar com ótimos drinks, atuando junto aos clientes desde 2015. Contamos com diversas opções de drinks e petiscos.")
                            .font(.system(size: 16))
                            .lineLimit(nil)
                            .padding(.vertical)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        HStack{
                            VStack{
                                createCustomIcon(imageName: "Instagram")
                                Text("Instagram")
                                    .font(.system(size: 10))
                            }
                            VStack{
                                createSystemIcon(imageName: "car.fill")
                                Text("Uber")
                                    .font(.system(size: 10))
                            }
                            VStack{
                                createSystemIcon(imageName: "square.and.arrow.up")
                                Text("Compartilhar")
                                    .font(.system(size: 10))
                            }
                            Spacer()
                        }
                        .padding(.bottom)
                        
                        HStack {
                            Text("Boa escolha para ...")
                                .font(.system(size: 14))
                            Spacer()
                        }
                        
                        HStack{
                            createMood(mood: "mood")
                            createMood(mood: "mood")
                            createMood(mood: "mood")
                        }
                    }
                    .padding(.horizontal)
                case .info:
                    Text("aa")
                case .review:
                    Text("aa")
                    
   
            }

            
            
            
            Spacer()
        }
        .navigationBarTitle("Deus Bar", displayMode: .inline)
    }
}

struct BarPageView_Previews: PreviewProvider {
    static var previews: some View {
        BarPageView()
    }
}
