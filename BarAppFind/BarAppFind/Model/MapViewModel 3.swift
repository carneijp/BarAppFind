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
    static let zoomArea: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
    
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
            return CLLocationCoordinate2D(latitude: -30.03421, longitude: -51.20884)
            
        case .cidadeBaixaCoordinate:
            return CLLocationCoordinate2D(latitude: -30.03763, longitude: -51.22270)
            
        case .quartoDistritoCoordinate:
            return CLLocationCoordinate2D(latitude: -30.009066, longitude: -51.206277)
        }
    }
}

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var chosen: MapDetails? = nil
    @Published var latitude: Double? = nil
    @Published var longitude: Double? = nil
//    @Published var heading: CLHeading? = nil
    @Published var userLocation: MKCoordinateRegion?
    @Published var region = MKCoordinateRegion(center: MapDetails.initialCoordinate , span: MapDetails.defaultSpan)
    
    var locationManager: CLLocationManager?
    
    func wheretoZoom(){
        self.chekIfLocationService(){
            
        }
            if let fixlatitude = self.latitude, let fixLongitude = self.longitude{
                self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: fixlatitude, longitude: fixLongitude) , span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
            }else if let location = self.chosen{
                self.region = MKCoordinateRegion(center: location.coordinate, span: MapDetails.zoomArea)
            }else if let user = self.userLocation{
                self.region = user
            }
        }
    
    func chekIfLocationService(completion: @escaping (Bool) -> Void) {
//        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager = CLLocationManager()
                self.locationManager!.delegate = self
            }else{
                print("location servise desable, please enable for a better experience.")
            }
//        }
    }
    
//    func checkForLocation() {
//        DispatchQueue.global().async {
//            if CLLocationManager.locationServicesEnabled() {
//                self.locationManager = CLLocationManager()
//                self.locationManager!.delegate = self
//            }else{
//                print("location servise desable, please enable for a better experience.")
//            }
//        }
//    }
    
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
//                locationManager.startUpdatingHeading()
//                self.heading = locationManager.heading
                if let a = locationManager.location?.coordinate {
                    self.userLocation = MKCoordinateRegion(center: a,
                                                           span:  MapDetails.defaultSpan)
                }
            }
            
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationPermission()
    }
}
