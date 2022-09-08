//
//  MapViewModel.swift
//  Move
//
//  Created by Silviu Preoteasa on 06.09.2022.
//

import Foundation
import MapKit


class ScooterMapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    var scooters: [ScooterAnnotation] = [] {
        didSet {
            refreshScooterList()
        }
    }
    var onSelectedScooter: (ScooterAnnotation) -> Void = { _ in }
    var onDeselectedScooter: () -> Void = {}
    
    lazy var mapView: MKMapView = {
       let mapView = MKMapView(frame: .zero)
        mapView.delegate = self
        mapView.showsUserLocation = true
//        mapView.userTrackingMode = .follow
        return mapView
        
    }()
    
    func checkIfLocationServiceIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
//            locationManager!.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        } else {
            print("Location not enabled")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Restricted")
        case .denied:
            print("Denied location")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }

    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkIfLocationServiceIsEnabled()
    }
    
    func refreshScooterList() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(scooters)
    }
}

extension ScooterMapViewModel: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor
         annotation: MKAnnotation) -> MKAnnotationView?{
       //Custom View for Annotation
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customView")
        
        
        
        if annotation is MKUserLocation {
            let mapRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(mapRegion, animated: true)
            return nil
        }
        annotationView.clusteringIdentifier = "customView"
        //Your custom image icon
        annotationView.image = UIImage(named: "ClusterDefault")
        
        if annotation is MKClusterAnnotation {
            //change data about the clusters
            let clusterConvertedAnnotation = annotation as! MKClusterAnnotation
            let numberOfItems = clusterConvertedAnnotation.memberAnnotations.count
            if numberOfItems > 1 {
                let lbl = UILabel()
                annotationView.addSubview(lbl)
                lbl.text = String(numberOfItems)
                lbl.translatesAutoresizingMaskIntoConstraints = false
                lbl.adjustsFontSizeToFitWidth = true;
                NSLayoutConstraint.activate([
                    lbl.widthAnchor.constraint(equalTo: annotationView.widthAnchor, multiplier: 0.5),
                    lbl.heightAnchor.constraint(equalTo: annotationView.heightAnchor),
                  lbl.centerXAnchor.constraint(equalTo: annotationView.centerXAnchor),
                    lbl.centerYAnchor.constraint(equalTo: annotationView.centerYAnchor, constant: -4)
                ])
            }
        }
        return annotationView
     }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            return
        }
        
        if let scooterAnnotation = view.annotation as? ScooterAnnotation {
            self.onSelectedScooter(scooterAnnotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        self.onDeselectedScooter()
    }
    
    
}
