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
    @State var barsList: [Bar] = [Bar(name: "asd", description: "asd", mood: ["asdasd"], grade: 1.0, latitude: -31, longitude: -51, operatinhours: ["20:00"], endereco: "Rua Jorge", regiao: "Brasil", caracteristicas: ["soda"])]
    @ObservedObject var viewModel = MapViewModel()
    @EnvironmentObject var cloud: CloudKitCRUD
    let mapStyle: MapStyle
    
    var body: some View {
        ZStack{
            
//            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: cloud.barsList) { bar in
                
                // LIMITADO - Usar MapMarker
                // RUIM - Reimplementar isso do zero
                // Trazer o mapa de UIKit
                    MapMarker(coordinate: bar.coordinate)
                }
                .onAppear {
                    viewModel.wheretoZoom()
                }
                .onChange(of: viewModel.chosen) { newValue in
                    viewModel.wheretoZoom()
                }
                
            if mapStyle == .large{
                VStack{
                    ComponenteLargeMap(chosen: $viewModel.chosen)
                        .environmentObject(viewModel)
                    Spacer()
                }
            }
            
        }
    }
}

struct ComponenteLargeMap: View {
    @Binding var chosen: MapDetails?
    @EnvironmentObject var viewModel: MapViewModel
    @State var showListMenu: Bool = false
    
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
            buttonUser
            
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
            }.padding(.bottom)
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


