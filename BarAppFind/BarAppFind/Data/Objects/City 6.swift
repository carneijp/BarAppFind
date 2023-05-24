//
//  City.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 30/04/23.
//

import Foundation
import SwiftUI
import CoreLocation

class City: ObservableObject {
    var name: String
    @Published var bars: [Bar] = []
    init(name:String) {
        self.name = name
    }
    func addBar(bar: Bar){
        bars.append(bar)
    }
}

class Bar: ObservableObject, Hashable, Identifiable {
    static func == (lhs: Bar, rhs: Bar) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
    
    @StateObject var cloud = CloudKitCRUD()
    var name: String
    var description: String
    var caracteristicas: [String]
    var mood: [String]
    var expensive: String = ""
    var grade: Double
    var reviews: [Review] = []
    var operatinHours: [String]
    var photosTOSave: [String] = []
    var photosLogo: URL? = nil
    var photoLogoTOSave: String = ""
    var photosToUse: [URL?] = []
    var latitude: Double
    var longitude: Double
    var endereco: String
    var regiao: String
    var coordinate: CLLocationCoordinate2D
    var linktInsta: String = ""
    
    
    init(name: String, description: String, mood: [String], grade: Double, latitude: Double, longitude: Double, operatinhours: [String], endereco: String, regiao: String, caracteristicas: [String]) {
        self.name = name
        self.description = description
        self.caracteristicas = caracteristicas
        self.mood = mood
        self.grade = grade
        self.operatinHours = operatinhours
        self.latitude = latitude
        self.longitude = longitude
        self.endereco = endereco
        self.regiao = regiao
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    func recieveLogoPhoto(logo: URL){
        self.photosLogo = logo
    }
    func recieveAllPhotos(photosToSAVE:[String]){
        self.photosTOSave = photosToSAVE
    }
    func recieveAllPhotos(photosToUSE:[URL]){
        self.photosToUse = photosToUSE
    }
    
//    private func mediaGrade(){
//        
//        
//        
//        
//    }
//    func recieveAllReviews(){
//        cloud.fetchItemsReview(barName: self.name){
//            self.reviews = self.cloud.reviewListByBar
//        }
//        
//    }
    
}

class Review: ObservableObject, Hashable, Identifiable {
    
    
    var writerEmail: String
    var writerName: String
    var grade: Double
    var description: String
    var barName: String
    
    init(writerEmail: String, writerName: String, grade: Double, description: String, barName: String) {
        self.writerEmail = writerEmail
        self.writerName = writerName
        self.grade = grade
        self.description = description
        self.barName = barName
    }
    
    static func == (lhs: Review, rhs: Review) -> Bool {
        lhs.writerName == rhs.writerName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(writerEmail)
        hasher.combine(barName)
    }
}

var trendings: [String] = ["trending1","trending2","trending3"]
var moodsImage: [String] = ["Família","Fofoca","Barzinho","Esquenta","Casal","Temático"]
var moodsName: [String] = ["Família","Fofoca","Barzinho","Esquenta","Casal","Temático"]
var moodsBanner: [String] = ["Família2","Fofoca2","Barzinho2","Esquenta2","Casal2","Temático2"]
var moodsColors: [String] = ["Família3","Fofoca3","Barzinho3","Esquenta3","Casal3","Temático3"]
var conquestMedals: [String] = ["Bom finer", "Já sabe do que gosta", "Nível 2", "Nível 3", "Nível 4", "Nível 5", "Nível 6"]
var medalDescriptions: [String] = ["Você conhece todos os bares do bairro Bom Fim! 🤩", "Você já definiu o seu gosto dentro do app 🤩"]
let ambient = ["Ao ar livre":"leaf", "Madrugada":"moon.stars", "Aceita pets":"pawprint.circle", "Estacionamento":"e.circle", "Climatizado":"snowflake", "Wifi":"wifi", "Permitido fumar":"cigarro",]




