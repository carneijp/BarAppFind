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
    
    // MARK: - Setup View
    enum ChoiceBar {
        case barName, info, review
    }
    
    @State var barname: String?
    @State var topBarChoice: ChoiceBar = .barName
    @State var isBarName: Bool = true
    @State var isInfo: Bool = false
    @State var isReview: Bool = false
    @State var isShowingWorkingHours: Bool = true
    @State var bar: Bar
    @State var reviewListIsEmpty: Bool = true
    @EnvironmentObject var cloud: Model
    @State private var showSignInAlert: Bool = false
    @State var isLoading: Bool = true
    @State private var viewIndex: Int = 1
    @State private var showReviewError: Bool = false
    @State private var imageIndex: Int = 0
    @State private var imagesBuildFromURL: [UIImage] = []
    @Namespace private var nameSpace
    
    @State var CurretDragOffsetX: CGFloat = 0
    
    // MARK: - Front-End View
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack{
                    if self.isLoading == false {

                        //MARK: carrossel para receber n imagens
                        VStack{
                            TabView(selection: $imageIndex) {
                                ForEach(imagesBuildFromURL.indices, id:\.self) { index in
                                    Image(uiImage: imagesBuildFromURL[index])
                                        .resizable()
                                        .scaledToFill()
                                        .clipped()
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 650)
                        }
                        .padding(.bottom, 10)
                        
                        VStack{
                            //MARK: tabBar
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
                                                .matchedGeometryEffect(id: "SelectedTab", in: nameSpace)
                                        }
                                    }else{
                                        VStack(spacing: 4){
                                            Text("Sobre o lugar")
                                                .font(.system(size: 16))
                                            
                                                .foregroundColor(.secondary)
                                                .onTapGesture {
                                                    withAnimation(.easeInOut(duration: 0.2)) {
                                                        self.topBarChoice = .barName
                                                        isBarName = true
                                                        isInfo = false
                                                        isReview = false
                                                    }
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
                                                .matchedGeometryEffect(id: "SelectedTab", in: nameSpace)
                                        }
                                    }else{
                                        VStack(spacing: 4){
                                            Text("Informações")
                                                .font(.system(size: 16))
                                                .foregroundColor(.secondary)
                                                .onTapGesture {
                                                    withAnimation(.easeInOut(duration: 0.2)) {
                                                        self.topBarChoice = .info
                                                        isBarName = false
                                                        isInfo = true
                                                        isReview = false
                                                    }
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
                                                .matchedGeometryEffect(id: "SelectedTab", in: nameSpace)
                                        }
                                    }else{
                                        VStack(spacing: 4){
                                            Text("Avaliações")
                                                .font(.system(size: 16))
                                                .foregroundColor(.secondary)
                                                .onTapGesture {
                                                    withAnimation(.easeInOut(duration: 0.2)) {
                                                        self.topBarChoice = .review
                                                        isBarName = false
                                                        isInfo = false
                                                        isReview = true
                                                    }
                                                    
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
//                                    if let barAtual = bar {
                                        AboutTheBar(bar: bar)
                                            .environmentObject(cloud)
                                            .padding(.bottom)
//                                    }
                                    
                                    // MARK: - Informações
                                    
                                case .info:
//                                    if let barAtual = bar {
                                        BarInformationView(bar: bar)
                                            .padding(.horizontal, 24)
//                                    }
                                    
                                    //MARK: - Avaliações
                                    
                                case .review:
                                    VStack{
                                        if let client = cloud.client {
                                            if cloud.reviewListByBar.filter( { client.firstName == $0.writerName } ).count == 0 {
                                                TextFieldComponent(barName: bar.name, viewIndex: $viewIndex, showSignIn: $showSignInAlert, showReviewError: $showReviewError)
                                                    .padding(.bottom)
                                            }
                                        } else {
                                            TextFieldComponent(barName: bar.name, viewIndex: $viewIndex, showSignIn: $showSignInAlert, showReviewError: $showReviewError)
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
                                    .padding(.bottom, 50)
                                    .padding(.top)
                            }
                        }
                        .gesture(
                            DragGesture()
                                .onChanged{ value in
                                    CurretDragOffsetX = value.translation.width
                                    print(CurretDragOffsetX)
                                }
                                .onEnded{ value in
                                    if abs(CurretDragOffsetX) > 150 {
                                        switch topBarChoice{
                                            case .barName:
                                                if CurretDragOffsetX < 0{
                                                    self.topBarChoice = .info
                                                    isBarName = false
                                                    isInfo = true
                                                    isReview = false
                                                }
                                                
                                            case .info:
                                                if CurretDragOffsetX < 0{
                                                    self.topBarChoice = .review
                                                    isBarName = false
                                                    isInfo = false
                                                    isReview = true
                                                } else {
                                                    self.topBarChoice = .barName
                                                    isBarName = true
                                                    isInfo = false
                                                    isReview = false
                                                }
                                            case .review:
                                                if CurretDragOffsetX > 0{
                                                    self.topBarChoice = .info
                                                    isBarName = false
                                                    isInfo = true
                                                    isReview = false
                                                }
                                        }
                                    }
                                }
                        )
                    }
                }
                .padding(.bottom, 130)
                .onAppear() {
//                    if bar?.name != barname {
//                        cloud.fetchBar(barName: barname) { bar in
//                            self.bar = bar
                    DispatchQueue.global().async {
                        for i in (0 ..< (self.bar.photosToUse.count)){
                            if let data = try? Data(contentsOf: bar.photosToUse[i]), let image = UIImage(data: data){
                                self.imagesBuildFromURL.append(image)
                            }
                        }
                    }
//                            self.isLoading = false
//                        }
//                    }
                    self.barname = bar.name
                    self.cloud.reviewListByBar = []
                    cloud.fetchReviews(barName: bar.name) {
                        self.isLoading = false
                    }
                }
            }
            .navigationBarTitle("\(bar.name)", displayMode: .inline)
            
            // MARK: - Pop Ups View
            
            if isLoading {
                LoadingViewModel()
                    .padding(.bottom, 130)
            }
            
//            ReviewReportOptions(ispresentedReportOptions: $showReportOptions, selectedReview: selectedReview)
            
//            LoginAlertComponent(title: "Login Necessário!", description: "Para avalar este bar, realize o seu login!", isShow: $showSignInAlert)
            
            ReviewAlertComponent(title: "Avaliação Necessária!", description: "Para prosseguir, é necessário atribuir pelo menos uma estrela à avaliação deste bar.", isShow: $showReviewError)
            
        }
        .padding(.top, 130)
    }
}

// MARK: - Auxiliar Functions

extension BarPageView {
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
        
//        cloud.barsList[index].grade = finalGrade
        
        cloud.barsList[index].grade = finalGrade
        let newBar = cloud.barsList[index].updateBar(newGrade: finalGrade)
        cloud.updateBar(updatedBar: newBar) { }
//        cloud.changeGrade(grade: finalGrade, barName: bar.name)
        
        return finalGrade
    }
    
    func getDateOfweek() -> Int {
        let index = Calendar.current.component(.weekday, from: Date())
        return (index + 5) % 7
    }
}
