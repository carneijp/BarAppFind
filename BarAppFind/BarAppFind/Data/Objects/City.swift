//
//  City.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 30/04/23.
//

import Foundation
import SwiftUI

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

class Bar: ObservableObject {
    @StateObject var cloud = CloudKitCRUD()
    var name: String
    var description: String
    var fakeID: String
    var mood: [String]
    var expensive: String = ""
    var grade: Double
    var reviews: [Review] = []
    var operatinHours: [String]
    var photosTOSave: [String] = []
    var photosToUse: [URL?] = []
    var latitude: Double
    var longitude: Double
    var endereco: String
    var regiao: String
    
    init(name: String, description: String, fakeID: String, mood: [String], grade: Double, latitude: Double, longitude: Double, operatinhours: [String], endereco: String, regiao: String) {
        self.name = name
        self.description = description
        self.fakeID = fakeID
        self.mood = mood
        self.grade = grade
        self.operatinHours = operatinhours
        self.latitude = latitude
        self.longitude = longitude
        self.endereco = endereco
        self.regiao = regiao
    }
    func recieveAllPhotos(photosToSAVE:[String]){
        self.photosTOSave = photosToSAVE
    }
    func recieveAllPhotos(photosToUSE:[URL]){
        self.photosToUse = photosToUSE
    }
    func recieveAllReviews(){
        cloud.fetchItemsReview(barName: self.name)
        self.reviews = cloud.reviewListByBar
    }
    
}

struct Review {
    var writerEmail: String
    var writerName: String
    var grade: Double
    var description: String
    var barName: String
}
