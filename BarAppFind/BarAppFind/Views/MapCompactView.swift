//
//  Map.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//

import SwiftUI
import MapKit
import CloudKit

struct MapCompactView: View {
    @State var barsList: [Bar] = []
    var bar: Bar?
    @EnvironmentObject var viewModel: MapViewModel
    @EnvironmentObject var cloud: Model
    @State var shownBar: Bar?
    @State var showBarSmallDescription: Bool = false
    @State var didTap: Bool = false
    @State var firstAppear: Bool = true
    
    var body: some View {
        
        ZStack {
            if let barChosen = bar {
                Map(coordinateRegion: $viewModel.region,showsUserLocation: true,  annotationItems: [barChosen]) {bar in
                    MapAnnotation(coordinate: bar.coordinate) {
                        Group{
                            VStack{
                                Image(systemName: "mappin.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 36)
                                    .foregroundColor(.red)
                                Circle()
                                    .scaledToFit()
                                    .frame(height: 5)
                                    .foregroundColor(.red)
                                    .fixedSize()
                                    .offset(y:-6)
                            }
                            .frame(width:60 ,height:60)
                        }
                    }
                }
                .tint(Color("blue"))
            }
        }
        .onAppear {
            viewModel.latitude = bar?.latitude
            viewModel.longitude = bar?.longitude
            viewModel.wheretoZoom()
        }
    }
}


