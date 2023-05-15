//
//  MapViewModel.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//
import MapKit

enum MapDetails{
    case bomFimCoordinate
    case cidadeBaixaCoordinate
    case quartoDistritoCoordinate
    static let initialCoordinate = CLLocationCoordinate2D(latitude: -30.038563, longitude: -51.199948)
    static let defaultSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    
    var description: String {
        switch self {
        case .bomFimCoordinate:
            return "Bom Fim"
        case .cidadeBaixaCoordinate:
            return "Cidade Baixa"
        case .quartoDistritoCoordinate:
            return "Quarto Distrito"
        }
    }
    
    var coordinate: CLLocationCoordinate2D {
        switch self {
        case .bomFimCoordinate:
            return CLLocationCoordinate2D(latitude: -30.032882, longitude: -51.213410)
            
        case .cidadeBaixaCoordinate:
            return CLLocationCoordinate2D(latitude: -30.039670, longitude: -51.223117)
            
        case .quartoDistritoCoordinate:
            return CLLocationCoordinate2D(latitude: -30.009066, longitude: -51.206277)
        }
    }
}

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var chosen: MapDetails? = nil
    @Published var latitude: Double? = nil
    @Published var longitude: Double? = nil
    @Published var userLocation: MKCoordinateRegion?
    @Published var region = MKCoordinateRegion(center: MapDetails.initialCoordinate , span: MapDetails.defaultSpan)
    
    var locationManager: CLLocationManager?
    
    func wheretoZoom(){
            self.chekIfLocationService()
            if let fixlatitude = self.latitude, let fixLongitude = self.longitude{
                self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: fixlatitude, longitude: fixLongitude) , span: MapDetails.defaultSpan)
            }else if let location = self.chosen{
                self.region = MKCoordinateRegion(center: location.coordinate, span: MapDetails.defaultSpan)
            }else if let user = self.userLocation{
                self.region = user
            }
    }
    
    func chekIfLocationService() {
        
        DispatchQueue.global(qos: .userInitiated).async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager = CLLocationManager()
                self.locationManager!.delegate = self
            }else{
                print("location servise desable, please enable for a better experience.")
            }
        }
    }
    
    private func checkLocationPermission() {
        
        guard let locationManager = locationManager else {return}
        
        switch locationManager.authorizationStatus{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("your location is restricted")
        case .denied:
            print("You have denied location permission, you can change on settings.")
        case .authorizedAlways, .authorizedWhenInUse:
            DispatchQueue.main.async {
                self.userLocation = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                            span:  MapDetails.defaultSpan)
            }
            
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        checkLocationPermission()
    }
}
