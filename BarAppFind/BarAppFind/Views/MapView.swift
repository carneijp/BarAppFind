//
//  Map.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//

import SwiftUI
import MapKit
import CloudKit

enum MapStyle {
    case compact, large
}



struct MapView: View {
    @State var barsList: [Bar] = []
    var bar: Bar?
    @ObservedObject var viewModel = MapViewModel()
    @EnvironmentObject var cloud: CloudKitCRUD
    let mapStyle: MapStyle
    @State var shownBar: Bar?
    @State var showBarSmallDescription: Bool = false
    
    var body: some View {
        if mapStyle == .large{
            ZStack{
                
                //            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: cloud.barsList) { bar in
                    MapAnnotation(coordinate: bar.coordinate){
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
                                    .foregroundColor(.black)
                                    .fixedSize()
                                    .offset(y:-6)
                            }
                            .frame(width:60 ,height:60)
                        }
                        .onTapGesture {
                            if showBarSmallDescription && shownBar != bar{
                                shownBar = bar
                            }else{
                                shownBar = bar
                                showBarSmallDescription = true
                            }
                            
                        }
                    }
                }
                .onTapGesture {
                    showBarSmallDescription = false
                }
                VStack{
                    ComponenteLargeMap(chosen: $viewModel.chosen, shownBar: $shownBar, showBarSmallDescription: $showBarSmallDescription)
                        .environmentObject(viewModel)
                    Spacer()
                }
                
            }
            .onAppear {
                viewModel.wheretoZoom()
            }
            .onChange(of: viewModel.chosen) { newValue in
                viewModel.wheretoZoom()
            }
            
        }else{
            if mapStyle == .compact{
                ZStack{
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
                                        //
                                        Circle()
                                            .scaledToFit()
                                            .frame(height: 5)
                                            .foregroundColor(.black)
                                            .fixedSize()
                                            .offset(y:-6)
                                    }
                                    .frame(width:60 ,height:60)
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.latitude = bar?.latitude
                    viewModel.longitude = bar?.longitude
                    viewModel.wheretoZoom()
                }
            }
        }
    }
}



struct ComponenteLargeMap: View {
    @Binding var chosen: MapDetails?
    @EnvironmentObject var viewModel: MapViewModel
    @State var showListMenu: Bool = false
    @Binding var shownBar: Bar?
    @Binding var showBarSmallDescription: Bool
    
    var body: some View {
        VStack{
            
            VStack{
                Text("Bairros")
                    .font(.title2)
                    .bold()
                menu
                    .shadow(radius: 5)
                    .padding()
                
            }.background(Color.white)
            if showListMenu{
                listViewModel(showListMenu: $showListMenu, chosen: $viewModel.chosen)
                    .padding(.horizontal)
            }
            Spacer()
            if showBarSmallDescription{
                NavigationLink{
                    if let barName = shownBar?.name{
                        BarPageView(barname: barName)
                    }
                }label: {
                    if let bar = shownBar{
                        MapPopUpComponent(bar: bar)
                    }
                }
                
            }else{
                buttonUser
            }
        }
        
    }
}


extension ComponenteLargeMap {
    private var menu: some View {
        VStack(){
            Button{
                showListMenu.toggle()
            }label: {
                Text(chosen?.description ?? "Selecione um bairro")
                    .foregroundColor(.black)
                    .font(.title3)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay(alignment: .trailing) {
                        if showListMenu{
                            Image(systemName: "chevron.up")
                                .foregroundColor(.black)
                        }else{
                            Image(systemName: "chevron.down")
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
            }
            
        }
        .background(Color(.white))
        .cornerRadius(10)
    }
    
    private var buttonUser: some View {
        HStack{
            Spacer()
            Button{
                chosen = nil
                viewModel.wheretoZoom()
                
            }label: {
                Image(systemName: "location.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaledToFit()
            }.padding()
        }
    }
}


struct listViewModel: View{
    @Binding var showListMenu: Bool
    @Binding var chosen: MapDetails?
    @EnvironmentObject var viewModel: MapViewModel
    var body: some View{
        List{
            Button{
                chosen = .quartoDistritoCoordinate
                showListMenu = false
            }label: {
                Text("Quarto Distrito")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .listRowSeparator(.hidden)
            
            Button{
                chosen = .cidadeBaixaCoordinate
                showListMenu = false
            }label: {
                Text("Cidade Baixa")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .listRowSeparator(.hidden)
            
            Button{
                chosen = .bomFimCoordinate
                showListMenu = false
            }label: {
                Text("Bom Fim")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .frame(maxHeight: 140)
    }
}


struct Map_Previews: PreviewProvider {
    static var previews: some View {
        MapView(mapStyle: .large)
    }
}


