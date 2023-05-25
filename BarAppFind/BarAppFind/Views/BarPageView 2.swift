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
        
    enum ChoiceBar {
        case barName, info, review
    }
    
    func Group() {
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
                }
                Text(text)
                    .font(.system(size: 10))
                
            }
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
    @State private var showSignInAlert: Bool = false
    @State var isLoading: Bool = true
    
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack{
                    
                    if let photoLogo = bar?.photosToUse[0], let data = try? Data(contentsOf: photoLogo), let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 650)
                            .clipped()
                            .padding(.bottom, 10)
                    }
                    
                    //MARK: tabBar
                    
                    if self.isLoading == false {
                        HStack{
                            //sobre o lugar
                            SwiftUI.Group{
                                if isBarName{
                                    VStack(spacing: 4){
                                        Text("Sobre o lugar")
                                            .font(.system(size: 16))
                                            .foregroundColor(.primary)
                                        
                                        Rectangle()
                                            .frame(height: 1)
                                            .foregroundColor(.primary)
                                            .frame(width: (UIScreen.main.bounds.width - 53) / 3)
                                    }
                                }else{
                                    VStack(spacing: 4){
                                        Text("Sobre o lugar")
                                            .font(.system(size: 16))
                                        
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
                            SwiftUI.Group{
                                if isInfo{
                                    VStack(spacing: 4){
                                        Text("Informações")
                                            .font(.system(size: 16))
                                            .foregroundColor(.primary)
                                        
                                        Rectangle()
                                            .frame(height: 1)
                                            .foregroundColor(.primary)
                                            .frame(width: (UIScreen.main.bounds.width - 53) / 3)
                                    }
                                }else{
                                    VStack(spacing: 4){
                                        Text("Informações")
                                            .font(.system(size: 16))
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
                                            .frame(width: (UIScreen.main.bounds.width - 53) / 3)
                                    }
                                }
                            }
                            
                            //Avaliações
                            SwiftUI.Group{
                                if isReview{
                                    VStack(spacing: 4){
                                        Text("Avaliações")
                                            .font(.system(size: 16))
                                            .foregroundColor(.primary)
                                        
                                        Rectangle()
                                            .frame(height: 1)
                                            .foregroundColor(.primary)
                                            .frame(width: (UIScreen.main.bounds.width - 53) / 3)
                                    }
                                }else{
                                    VStack(spacing: 4){
                                        Text("Avaliações")
                                            .font(.system(size: 16))
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
                                    Text("\(bar?.name ?? "")")
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
                                            Text(String(format: "%.1f", bar.grade))
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
                                                showSignInAlert = true
                                            }
                                        
                                    }
                                    
                                }
                                .padding(.top, 18)
    // <<<<<<< HEAD
                                .padding(.horizontal, 24)
                                .padding(.bottom, 6)
                                
                                // MARK: - FAZER LÓGICA DAS CORES AQUI
                                if let horario = bar?.operatinHours[getDateOfweek()] {
                                    if horario.localizedCaseInsensitiveContains("fechado"){
                                        Text(bar?.operatinHours[getDateOfweek()] ?? "Loading...")
                                            .font(.system(size: 14))
                                            .padding(.vertical, 6)
                                            .padding(.horizontal, 20)
                                            .background(.red.opacity(0.3))
                                            .cornerRadius(8)
                                            .padding(.horizontal, 24)
                                            .padding(.bottom, 12)
                                            .shadow(radius: 1, y: 2)
                                    }else{
                                        Text(bar?.operatinHours[getDateOfweek()] ?? "Loading...")
                                            .font(.system(size: 14))
                                            .padding(.vertical, 6)
                                            .padding(.horizontal, 20)
                                            .background(.green.opacity(0.3))
                                            .cornerRadius(8)
                                            .padding(.horizontal, 24)
                                            .padding(.bottom, 12)
                                            .shadow(radius: 1, y: 2)
                                    }
                                }else{
                                    Text("Loading...")
                                        .font(.system(size: 14))
                                        .padding(.vertical, 6)
                                        .padding(.horizontal, 20)
                                }
                                // MARK: -
                                
                                Text(bar?.description ?? "Loading...")
                                    .font(.system(size: 16))
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.bottom)
                                    .padding(.horizontal, 24)
                                
                                Text("Moods para este bar:")
                                    .padding(.horizontal, 24)
                                    .font(.system(size: 16))
                                    .bold()
                                    .padding(.bottom, -8)
                                    .padding(.top, 10)
                                
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
                                    .padding(.horizontal, 24)
                                }
                                
                                HStack {
                                    Text("Sobre o ambiente")
                                        .font(.system(size:20))
                                        .bold()
                                    Spacer()
                                }
                                .padding(.vertical)
                                .padding(.horizontal, 24)
                                
                                if let caracteristicas = bar?.caracteristicas{
                                    VStack(alignment: .leading){
                                        ForEach(caracteristicas, id:\.self){ caracteristica in
                                            Text("• \(caracteristica)")
                                                .font(.system(size: 16))
                                                .padding(.bottom, 3)
                                        }
                                    }
                                    .padding(.horizontal, 24)
                                }
                            }
                            .padding(.bottom)

                        // MARK: - Informações
                            
                        case .info:
                            VStack(alignment: .leading){
                                
                                FlemisViewModel(indexEntrada: getDateOfweek(), workingHours: bar?.operatinHours ?? [] )
                                
                                
                                Text("Endereço")
                                    .font(.system(size: 20))
                                    .bold()
                                    .padding(.vertical)
                                HStack {
                                    Text("\(bar?.endereco ?? "Loading ...")")
                                        .lineLimit(nil)
                                        .multilineTextAlignment(.leading)
                                    
                                }
                                    
                                    MapView(bar: self.bar, mapStyle: .compact)
                                        .frame(height: 129)
                                        .cornerRadius(10)
                                
                                HStack{
                                    Button(action: {
                                        goToUber()
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
                                        goToInstaPage(link: bar!.linktInsta)
                                    }, label: {
                                    Image("Instagram2")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(.all, 5)
                                })
                                .frame(width: 166, height: 47)
                                .background(Color("amarelo"))
                                .cornerRadius(10)
                                }
                                .padding(.bottom)
                                
                            }
                            .padding(.horizontal, 24)
                            
                        //MARK: - Avaliações
                            
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
                                            .padding(.horizontal, 24)
                                    }
                                }else{
                                    EmptyViewReviews()
                                }
                            }
                            .padding(.top)
                        }

                    }
                }
                .padding(.bottom, 130)
                .onAppear(){
                    self.isLoading = true
                    
                    cloud.fetchBar(barName: barname) { bar in
                        self.bar = bar
                        self.isLoading = false
                    }
                    
                    self.cloud.reviewListByBar = []
                    
                    cloud.fetchItemsReview(barName: barname) {
                        self.isLoading = false
                    }
                }
                
            }.navigationBarTitle("\(bar?.name ?? "Loading ...")", displayMode: .inline)
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            
            LoginAlertComponent(title: "Login Necessário!", description: "Para favoritar bares, realize o seu login!", isShow: $showSignInAlert)
        }
        .padding(.top, 130)
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
    
    func goToInstaPage(link: String){
        let instagramURL = URL(string: link)!
        
        if UIApplication.shared.canOpenURL(instagramURL) {
            UIApplication.shared.open(instagramURL, options: [:], completionHandler: nil)
        } else {
            // Instagram app is not installed, open in Safari as a fallback
            let safariURL = URL(string: link)!
            UIApplication.shared.open(safariURL, options: [:], completionHandler: nil)
        }
    }
    
    
    func goToUber(){
        if let uberURL = URL(string: "uber://"){
            UIApplication.shared.canOpenURL(uberURL)
            UIApplication.shared.open(uberURL)
//            else {
                // Instagram app is not installed, open in Safari as a fallback
                let safariURL = URL(string: "https://apps.apple.com/us/app/uber/id368677368")!
                UIApplication.shared.open(safariURL, options: [:], completionHandler: nil)
//            }
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