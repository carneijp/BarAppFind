//
//  Map.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//

import SwiftUI
import MapKit
struct MapView: View {
    @StateObject var viewModel = MapViewModel()
    @EnvironmentObject var cloud: CloudKitCRUD

    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .onAppear {
                viewModel.wheretoZoom()
            }
            .navigationTitle("Map")
    }
}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
