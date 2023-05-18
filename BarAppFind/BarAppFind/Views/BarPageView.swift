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
                    .background(Color("gray5"))
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
    
    @State var reviewListIsEmpty: Bool = true
    
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
                                .foregroundColor(.primary)
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
                                .foregroundColor(.primary)
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
                                .foregroundColor(.primary)
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
                            //<<<<<<< HEAD
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
                            
                            //=======
                            //
                            //>>>>>>> featMaps
                        }
                        .padding(.top)
                        
                        
                        Text("\(bar?.description ?? "Loading...")")
                            .font(.system(size: 16))
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom)
                        
                        
                        //                            HStack{
                        //                                createCustomIcon(imageName: "Instagram", text: "Instagram")
                        //
                        //
                        //                                createSystemIcon(imageName: "square.and.arrow.up",text: "Compartilhar")
                        //                            }
                        //                            .padding(.bottom)
                        
                        Text("Boa escolha para ...")
                            .font(.system(size: 14))
                            .padding(.bottom)
                        
                        HStack{
                            if let moods = bar?.mood{
                                ForEach(moods, id:\.self){ mood in
                                    BarViewMoodComponent(mood: mood)
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
                                VStack(alignment: .leading){
                                    ForEach(caracteristicas, id:\.self){ caracteristica in
                                        Text(caracteristica)
                                            .font(.system(size: 16))
                                            .padding(.bottom, 3)
                                    }
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
                        
                        Button{
                            callUber()
                        }label: {
                            Group{
                                HStack{
                                    Image(systemName: "car.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color("white"))
                                        .frame(height: 14)
                                        .padding(.leading)
                                    
                                    //                                Spacer()
                                    
                                    Text("Abrir no uber")
                                        .font(.system(size: 16))
                                        .bold()
                                        .foregroundColor(Color("white"))
                                    
                                    //                                Spacer()
                                }
                                .frame(width:UIScreen.main.bounds.width - 48, height: 41)
                                .background(Color("gray1"))
                                .cornerRadius(10)
                                .padding(.top)
                            }
                        }
                        
                        
                        
                    }
                    //                    .background(Color.green)
                    .padding(.horizontal)
                    
                    //MARK: Avaliações
                case .review:
                    VStack{
                        
                        if let client = cloud.client {
                            if cloud.reviewListByBar.filter( { client.firstName == $0.writerName } ).count == 0 {
                                TextFieldComponent(barName: self.barname)
                                    .padding(.bottom)
                            }
                        } else {
                            TextFieldComponent(barName: self.barname)
                                .padding(.bottom)
                        }
                        
                        if cloud.reviewListByBar.count != 0{
                            ForEach(cloud.reviewListByBar, id: \.self){ review in
                                ReviewComponent(review: review)
                            }
                        }else{
                            EmptyViewReviews()
                        }
                        
                        //                            if !reviewListIsEmpty{
                        //                                ForEach(cloud.reviewListByBar, id: \.self){ review in
                        //                                    ReviewComponent(review: review)
                        //                                }
                        //                            }else{
                        //                                EmptyViewReviews()
                        //                            }
                    }
                    .padding([.horizontal, .top])
                    
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
    
    func callUber(){
        if let uberURL = URL(string: "uber://"){
            UIApplication.shared.canOpenURL(uberURL)
            UIApplication.shared.open(uberURL)
        } else {
            let fallbackURL = URL(string: "https://apps.apple.com/us/app/uber/id368677368")!
            UIApplication.shared.open(fallbackURL)
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
            HStack(alignment: .center) {
                Text("Horário de Atendimento")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.primary)
                    .padding(.top)
                    .padding(.bottom, 5)
                //                    .background(Color.green)
                
                //                Spacer()
                
                Button(action: {
                    self.isShowingWorkingHours.toggle()
                }, label: {
                    Image(systemName: self.isShowingWorkingHours ? "chevron.up" : "chevron.down")
                        .resizable()
                        .scaledToFit()
                })
                .frame(width: 14, height: 28)
                //                .background(Color.green)
                
            }
            .padding(.bottom, 5)
            
            
            if self.isShowingWorkingHours {
                ForEach(self.workingHours, id: \.self) { workingHour in
                    Text("\(workingHour)")
                        .font(.system(size: 14))
                        .padding(.bottom, 5)
                }
                .scrollContentBackground(.hidden)
            }
        }
    }
}
