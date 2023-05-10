//
//  BarPageView.swift
//  BarAppFind
//
//  Created by Eduardo Pretto on 04/05/23.
//
import ClockKit
import Foundation
import SwiftUI
import MapKit

struct BarPageView: View {
    var barname: String
    
    let contacts = [
      "John",
      "Ashley",
      "Bobby",
      "Jimmy",
      "Fredie"
    ]
    
    enum ChoiceBar {
        case barName, info, review
    }
    
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
    
    @State var review: String = ""
    
    @State var topBarChoice: ChoiceBar = .barName
    
    @State var isBarName: Bool = true
    @State var isInfo: Bool = false
    @State var isReview: Bool = false
    
    @State var isShowingWorkingHours: Bool = true
    
    @EnvironmentObject var cloud: CloudKitCRUD
    
    
    
    var body: some View {
        
        VStack{
            Image("bakground")
                .resizable()
                .scaledToFit()
                .padding(.bottom, 10)
            
            //MARK: tabBar
            HStack{
                //sobre o lugar
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
                
                //Informações
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
                
                //Avaliações
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
                                self.topBarChoice = .review
                                isBarName = false
                                isInfo = false
                                isReview = true
                            }
                    }
                }
                
            }
            
            //Escolhas TabBar
            switch topBarChoice{
                    
                //MARK: Sobre o lugar
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
                        .padding(.top)
                        
  
                        
                        HStack {
                            Text("Bar com ótimos drinks, atuando junto aos clientes desde 2015. Contamos com diversas opções de drinks e petiscos.")
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
                    
                //MARK: Informações
                case .info:
                    ScrollView{
                        
                        Flemis(workingHours: cloud.chossenBar[0].operatinHours )
//                        NavigationView {
//                            VStack {
//                                List{
//                                    Section("Horários de atendimento") {
//                                        ForEach(contacts, id: \.self){ contact in
//                                            Text(contact)
//                                        }
//                                    }
//                                    .listRowSeparator(.hidden)
//                                }
//                                .scrollContentBackground(.hidden)
//                            }
//                        }
                        
                        
                        HStack {
                            Text("Endereço")
                                .font(.system(size: 20))
                            .bold()
                            Spacer()
                        }
                        HStack {
                            Text("Avenida Ipiranga, 6681 - Partenon 90719-303")
                                .lineLimit(nil)
                            .multilineTextAlignment(.leading)

                            Spacer()
                        }

                        MapView()
                            .frame(width: 342, height: 129)

                        HStack{
                            Image(systemName: "car.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 29)
                                .padding(.leading)

                            Spacer()

                            Text("Abrir no uber")

                            Spacer()
                        }
                        .frame(height: 41)
                        .background(Color.gray)
                        .cornerRadius(10)
                    }
//                    .background(Color.green)
                        .padding(.horizontal)
                    
                //MARK: Avaliações
                case .review:
                    ScrollView{
                        HStack {
                            Text("Queremos a sua avaliação")
                                .font(.system(size: 20))
                                .bold()
                                .padding(.vertical)
                            
                            Spacer()
                        }
                        
                        HStack{
                            Image(systemName: "star")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                            
                            Image(systemName: "star")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                            
                            Image(systemName: "star")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                            
                            Image(systemName: "star")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                            
                            Image(systemName: "star")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                            Spacer()
                        }
                            .padding(.bottom)
                        
                        
//                        HStack {
//                            Text("Escreva aqui")
//                                .font(.system(size: 14))
//                            Spacer()
//                        }
                        TextField("Escreva aqui", text: $review)
//                            .font(Font.system(size: 14))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
                            .foregroundColor(.black)
                            .frame(width: 342, height: 104)
                        
                    }
                    .padding(.horizontal)
                    
                    
   
            }

            
            
            
            Spacer()
        }
        .onAppear(){
            cloud.fetchBars(barName: barname)
        }
        .navigationBarTitle("Deusa Bar", displayMode: .inline)
    }
}

struct BarPageView_Previews: PreviewProvider {
    static var previews: some View {
        BarPageView(barname: "Quentins")
    }
}


struct Flemis: View {
    @State var isShowingWorkingHours: Bool = true
    
    var workingHours: [String]
    
    var body: some View {
        VStack {
            HStack {
                Text("adsosakdiasda")
                
                Spacer()
                
                Button(action: {
                    self.isShowingWorkingHours.toggle()
                }, label: {
                    Image(systemName: self.isShowingWorkingHours ? "chevron.up" : "chevron.down")
                })
            }
            
            if self.isShowingWorkingHours {
                ForEach(self.workingHours, id: \.self) { workingHour in
                    Text("\(workingHour)")
                }
                .scrollContentBackground(.hidden)
            }
        }
    }
}
