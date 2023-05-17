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
    
    private let ambient = ["Ao ar livre":"leaf", "Madrugada":"moon.stars", "Aceita pets":"pawprint.circle", "Estacionamento":"e.circle", "Climatizado":"snowflake", "Wifi":"wifi", "Permitido fumar":"cigarro",]
    
//    let contacts = [
//      "John",
//      "Ashley",
//      "Bobby",
//      "Jimmy",
//      "Fredie"
//    ]
    
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
    func createAmbientIcon(ambientText: String) -> some View{
        VStack{
            Image(ambient[ambientText, default: ""])
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 31)
            
            Text(ambientText)
                .font(.system(size: 6))
        }
    }
    
    //Criar icone de ambiente a partir de uma imagem qualquer (estacionamento)
//    @ViewBuilder
//    func createAmbientIconCustom(ambientText: String, imageName: String) -> some View{
//        VStack{
//            Image(imageName)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 35, height: 31)
//
//            Text(ambientText)
//                .font(.system(size: 6))
//        }
//    }
    
//    @State var review: String = ""
    
    @State var topBarChoice: ChoiceBar = .barName
    
    @State var isBarName: Bool = true
    @State var isInfo: Bool = false
    @State var isReview: Bool = false
    
    @State var isShowingWorkingHours: Bool = true
    
    @State var bar: Bar?
    
    @EnvironmentObject var cloud: CloudKitCRUD
    
    
    
    var body: some View {
        
        ScrollView {
            VStack{
                
                if let photoLogo = bar?.photosToUse[0], let data = try? Data(contentsOf: photoLogo), let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 10)
                }
                
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
                        VStack(alignment: .leading) {
                            HStack{
                                Text("\(bar?.name ?? "Loading...")")
                                    .font(.title2)
                                    .bold()
                                    .padding(.trailing)
                                
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15)
                                Text(String(format: "%.1f", bar?.grade ?? 0.0))
                                    .font(.system(size: 14))
                                
                                Spacer()
                                Image(systemName: "heart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15)
                                    .padding(.trailing, 15)
                                
                            }
                            .padding(.top)
                            
                            
                            Text("\(bar?.description ?? "Loading...")")
                                .font(.system(size: 16))
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.bottom)
                            
                            
                            HStack{
                                createCustomIcon(imageName: "Instagram", text: "Instagram")
                                
                                
                                createSystemIcon(imageName: "square.and.arrow.up",text: "Compartilhar")
                            }
                            .padding(.bottom)
                            
                            Text("Boa escolha para ...")
                                .font(.system(size: 14))
                                .padding(.bottom)
                            
                            HStack{
                                if let moods = bar?.mood{
                                    ForEach(moods, id:\.self){ mood in
                                        MoodComponent(mood: mood)
                                    }
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
                                //                                    createAmbientIconCustom(ambientText: "Estacionamento", imageName: "Estacionamento")
                                //                                    createAmbientIconSystem(ambientText: "Climatizado", imageName: "snowflake")
                                //                                    ForEach(bar?.caracteristicas, id: \.self){ caracteristica in
                                if let caracteristicas = bar?.caracteristicas{
                                    ForEach(caracteristicas, id:\.self){ caracteristica in
                                        createAmbientIcon(ambientText: caracteristica)
                                    }
                                }
                            }
                        }
                            .padding(.horizontal)
                        
                    //MARK: Informações
                    case .info:
                        VStack(alignment: .leading){
                            
                            Flemis(workingHours: bar?.operatinHours ?? [] )
                            
                            
                            Text("Endereço")
                                .font(.system(size: 20))
                                .bold()
                                .padding(.vertical)
                            HStack {
                                Text("\(bar?.endereco ?? "Loading ...")")
                                    .lineLimit(nil)
                                .multilineTextAlignment(.leading)

                                Spacer()
                            }

                            MapView(bar: self.bar, mapStyle: .compact)
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
                            TextFieldComponent(barName: self.barname)
                            ForEach(cloud.reviewListByBar, id: \.self){ review in
                                ReviewComponent(review: review)
                            }
                        }
                        .padding(.horizontal)

                }

                
                
                
                Spacer()
            }
            .onAppear(){
                cloud.fetchBar(barName: barname) { bar in
                    self.bar = bar
                }
                self.cloud.reviewListByBar = []
                cloud.fetchItemsReview(barName: barname) {}
            }
        .navigationBarTitle("\(bar?.name ?? "Loading ...")", displayMode: .inline)
        }
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
        VStack(alignment: .leading) {
            HStack {
                Text("Horário de Atendimento")
                    .font(.system(size: 20))
                    .bold()
                    .padding(.top)
                    .padding(.bottom, 5)
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
