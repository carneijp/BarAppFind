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
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 650)
//                        .frame(width: 498, height: 200)
                        .clipped()
                        .padding(.bottom, 10)
                }
                
                //MARK: tabBar
                HStack{
                    //sobre o lugar
                    Group{
                        if isBarName{
                            VStack(spacing: 4){
                                Text("Sobre o lugar")
                                    .font(.system(size: 14))
                                    .foregroundColor(.primary)
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.primary)
//                                    .frame(width: )
                                    .frame(width: (UIScreen.main.bounds.width - 53) / 3)
                            }
                        }else{
                            VStack(spacing: 4){
                            Text("Sobre o lugar")
                                .font(.system(size: 14))
                            
                                .foregroundColor(.secondary)
                                .onTapGesture {
                                    self.topBarChoice = .barName
                                    isBarName = true
                                    isInfo = false
                                    isReview = false
                                }
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.clear)
                                .frame(width: (UIScreen.main.bounds.width - 53) / 3)
                        }
                        }
                    }
                    
                    //Informações
                    Group{
                        if isInfo{
                            VStack(spacing: 4){
                                Text("Informações")
                                    .font(.system(size: 14))
//                                    .padding(.leading, 40)
                                    .foregroundColor(.primary)
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.primary)
//                                    .frame(width: )
                                    .frame(width: (UIScreen.main.bounds.width - 53) / 3)
                            }
                        }else{
                            VStack(spacing: 4){
                                Text("Informações")
                                    .font(.system(size: 14))
                                    .foregroundColor(.secondary)
                                    .onTapGesture {
                                        self.topBarChoice = .info
                                        isBarName = false
                                        isInfo = true
                                        isReview = false
                                    }
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.clear)
//                                    .frame(width: )
                                    .frame(width: (UIScreen.main.bounds.width - 53) / 3)
                            }
                        }
                    }
                    
                    //Avaliações
                    Group{
                        if isReview{
                            VStack(spacing: 4){
                                Text("Avaliações")
                                    .font(.system(size: 14))
                                    .foregroundColor(.primary)
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.primary)
                                    .frame(width: (UIScreen.main.bounds.width - 53) / 3)
                            }
                        }else{
                            VStack(spacing: 4){
                                Text("Avaliações")
                                    .font(.system(size: 14))
//                                    .padding(.leading, 40)
                                    .foregroundColor(.secondary)
                                    .onTapGesture {
                                        self.topBarChoice = .review
                                        isBarName = false
                                        isInfo = false
                                        isReview = true
                                        
                                    }
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.clear)
                                //                                    .frame(width: )
                                    .frame(width: (UIScreen.main.bounds.width - 53) / 3)
                                
                                
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
                            
                            if let bar = bar {
                                let review = cloud.reviewListByBar.filter({ $0.barName == bar.name })
                                
                                let countBars = review.count
                                
                                if countBars == 0 {
                                    Text(String(format: "%.1f", bar.grade) + " • \(bar.operatinHours[0])")
                                        .font(.system(size: 14))
                                }
                                else {
                                    Text(String(format: "%.1f", getFinalGrade(from: bar, review: review)))
                                        .font(.system(size: 14))
                                }
                            }
                            Spacer()
                            

                            if let cliente = cloud.client {
                                if cliente.favorites.contains(barname){
                                    Image(systemName:"heart.fill")
                                        .foregroundColor(.red)
                                        .onTapGesture {
                                            cloud.removeFavoriteBar(client: cliente, barName: barname)
                                            let referencia = cliente.favorites.firstIndex(of: barname)
                                            cliente.favorites.remove(at: referencia ?? -1)
                                            cloud.client = cliente
                                        }
                                }else{
                                    Image(systemName: "heart")
                                        .onTapGesture {
                                            cloud.addFavoriteBar(client: cliente, barName: barname)
                                            cliente.favorites.append(barname)
                                            cloud.client = cliente
                                        }
                                }
                                
                            } else{
                                Image(systemName: "heart")
                                    .onTapGesture {
                                        print("Voce deve estar logado para favoritar.")
                                    }
                                
                            }
                            
                        }
                        .padding(.top)
                        
                        
                        Text("\(bar?.description ?? "Loading...")")
                            .font(.system(size: 16))
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom)
                    
                        Text("Ótimo para ...")
                            .font(.system(size: 14))
//                            .padding(.bottom)
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                if let moods = bar?.mood{
                                    ForEach(moods, id:\.self){ mood in
                                        MoodSmallComponent(moodName: mood)
                                            .padding(.vertical)
                                            .padding(.trailing, 10)
                                    }
                                }
                            }
                            .padding(.leading, 4)
                        }
                        
                        HStack {
                            Text("Sobre o ambiente")
                                .font(.system(size:20))
                                .bold()
                            Spacer()
                        }
                        .padding(.vertical)
                        
//                        HStack{
                            if let caracteristicas = bar?.caracteristicas{
                                VStack(alignment: .leading){
                                    ForEach(caracteristicas, id:\.self){ caracteristica in
                                        Text(caracteristica)
                                            .font(.system(size: 16))
                                            .padding(.bottom, 3)
                                    }
                                }
                            }
//                        }
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
                            
//                            Spacer()
                        }
                        
// <<<<<<< HEAD
                            
                            MapView(bar: self.bar, mapStyle: .compact)
                                .frame(height: 129)

//
//                        HStack{
//                            Spacer()
//                            Image(systemName: "car.fill")
//                                .resizable()
//                                .scaledToFit()
//                                .foregroundColor(Color("white"))
//                                .frame(height: 14)
//                                .padding(.leading)
//                            Text("Abrir no uber")
//                                .font(.system(size: 16))
//                                .bold()
//                                .foregroundColor(Color("white"))
//                            Spacer()
//                        }
//                        .frame(height: 41)
//                        .background(Color("gray1"))
//                        .cornerRadius(10)
//                        .padding(.top)
                        
                        HStack{
                            Button(action: {
                                callUber()
                            }, label: {
                                Image("Uber")
                                    .resizable()
                                    .scaledToFit()
                            })
                            .frame(width: 166, height: 47)
                            .background(Color.black)
                            .cornerRadius(10)
                            
                            Spacer()
                            
                            Button(action: {
                                print("abrir 99")
                            }, label: {
                                Image("99")
                                    .resizable()
                                    .scaledToFit()
                            })
                            .frame(width: 166, height: 47)
                            .background(Color("amarelo"))
                            .cornerRadius(10)
                        }
                        .padding(.bottom)
// =======
                        
//                         MapView(bar: self.bar, mapStyle: .compact)
//                             .frame(width: 342, height: 129)
                        
//                         Button{
//                             callUber()
//                         }label: {
//                             Group{
//                                 HStack{
//                                     Image(systemName: "car.fill")
//                                         .resizable()
//                                         .scaledToFit()
//                                         .foregroundColor(Color("white"))
//                                         .frame(height: 14)
//                                         .padding(.leading)
                                    
//                                     //                                Spacer()
                                    
//                                     Text("Abrir no uber")
//                                         .font(.system(size: 16))
//                                         .bold()
//                                         .foregroundColor(Color("white"))
                                    
//                                     //                                Spacer()
//                                 }
//                                 .frame(width:UIScreen.main.bounds.width - 48, height: 41)
//                                 .background(Color("gray1"))
//                                 .cornerRadius(10)
//                                 .padding(.top)
//                             }
//                         }
                        
                        
                        
// >>>>>>> Dev
                    }
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
                    }
                    .padding([.horizontal, .top])
                    
                }

               // Spacer()
            }
            .onAppear(){
                cloud.fetchBar(barName: barname) { bar in
                    self.bar = bar
                }
                self.cloud.reviewListByBar = []
                cloud.fetchItemsReview(barName: barname) {}
            }
            
        }.navigationBarTitle("\(bar?.name ?? "Loading ...")", displayMode: .inline)
    }
    
    func getFinalGrade(from bar: Bar, review: [Review]) -> Double {
        let grade = review.map{$0.grade}.reduce(0, +)
        let finalGrade = Double(grade) / Double(review.count)
        var index: Int = 0
        for i in 0..<cloud.barsList.count{
            if cloud.barsList[i].name == bar.name{
                index = i
            }
        }
        if cloud.barsList.count <= 0 { return 0.0 }
        cloud.barsList[index].grade = finalGrade
        cloud.changeGrade(grade: finalGrade, barName: bar.name)
        return finalGrade
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
    
    func getDateOfweek() -> Int {
        let index = Calendar.current.component(.weekday, from: Date())
        return (index + 5) % 7
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
//                    .padding(.bottom, 5)
                
                Button(action: {
                    self.isShowingWorkingHours.toggle()
                }, label: {
                    Image(systemName: self.isShowingWorkingHours ? "chevron.up" : "chevron.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 34)
                        .offset(y: 8)
                        .foregroundColor(Color("gray4"))
                })
                .frame(width: 14, height: 28)
                
            }
//            .background(Color.red)
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
