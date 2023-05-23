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
                                if let barAtual = bar {
                                    AboutTheBar(bar: barAtual)
                                        .padding(.bottom)
                                }

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
        
        if cloud.barsList.count <= 0 {
            return 0.0
            
        }
        
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
