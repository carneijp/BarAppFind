//
//  BarInformationView.swift
//  Onde
//
//  Created by Eduardo Pretto on 23/05/23.
//

import SwiftUI

struct BarInformationView: View {
    
    @EnvironmentObject var cloud: CloudKitCRUD
    @State var bar: Bar
    
    var body: some View {
        VStack(alignment: .leading){
            
            FlemisViewModel(indexEntrada: getDateOfweek(), workingHours: bar.operatinHours)
            
            
            Text("Endereço")
                .font(.system(size: 20))
                .bold()
                .padding(.vertical)
            HStack {
                Text("\(bar.endereco)")
                    .textSelection(.enabled)
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
//                    Image("Uber")
                    Text("Uber")
                        .foregroundColor(.white)
                        .bold()
//                        .resizable()
                        .scaledToFit()
                        .frame(width: 166, height: 47)
                        .background(Color.black)
                })
                .cornerRadius(10)
                
                Spacer()
                
                Button(action: {
                    goToInstaPage(link: bar.linktInsta)
                }, label: {
                    Image("Instagram2")
                        .resizable()
                        .scaledToFit()
                        .padding(.all, 5)
                        .frame(width: 166, height: 47)
                        .background(Color("amarelo"))
                })
                .cornerRadius(10)
            }
            .padding(.bottom)
            
        }
    }
    
    func getDateOfweek() -> Int {
        let index = Calendar.current.component(.weekday, from: Date())
        return (index + 5) % 7
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
    
}


