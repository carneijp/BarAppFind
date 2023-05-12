//
//  Map.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//

import SwiftUI
import MapKit

enum MapStyle {
    case compact, large
}

struct MapView: View {
    @ObservedObject var viewModel = MapViewModel()
    @EnvironmentObject var cloud: CloudKitCRUD
    let mapStyle: MapStyle
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .onAppear {
                    //                    viewModel.chekIfLocationService()
                        viewModel.wheretoZoom()
                }
                .onChange(of: viewModel.chosen) { newValue in
                    viewModel.wheretoZoom()
                }
            if mapStyle == .large{
                VStack{
                    ComponenteLargeMap(chosen: $viewModel.chosen)
                        .environmentObject(viewModel)
                        .padding()
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
            Text("Bairros")
            menu
            Spacer()
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
}


extension ComponenteLargeMap {
    private var menu: some View{
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
            if showListMenu{
                listViewModel(showListMenu: $showListMenu, chosen: $viewModel.chosen)
            }
            
        }
        .background(Color(.white))
        .cornerRadius(10)
    }
}

struct listViewModel: View{
    @Binding var showListMenu: Bool
    @Binding var chosen: MapDetails?
    @EnvironmentObject var viewModel: MapViewModel
    var body: some View{
        List{
            Text("Cidade Baixa")
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    chosen = .cidadeBaixaCoordinate
                    showListMenu = false
                }
            Text("Quarto Distrito")
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    chosen = .quartoDistritoCoordinate
                    showListMenu = false
                }
            Text("Bom Fim")
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    chosen = .bomFimCoordinate
                    showListMenu = false
                }
        }
        .listStyle(PlainListStyle())
    }
}


struct Map_Previews: PreviewProvider {
    static var previews: some View {
        MapView(mapStyle: .large)
    }
}


