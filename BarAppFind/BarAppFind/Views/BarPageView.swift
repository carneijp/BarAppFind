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
            .padding(.horizontal)
            
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
            .padding(.horizontal)
            .padding(.top, -15)
//            .background(.gray)
            
            Text("Bar com ótimos drinks, atuando junto aos clientes desde 2015. Contamos com diversas opções de drinks e petiscos.")
                .font(.system(size: 16))
                .padding()
            
            HStack{
                Image(systemName: "car.fill")
                Image(systemName: "square.and.arrow.up")
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
