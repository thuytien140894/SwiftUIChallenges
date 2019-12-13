//
//  MapView.swift
//  PhotoTagger
//
//  Created by Tien Thuy Ho on 1/18/20.
//  Copyright © 2020 Tien Thuy Ho. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {

    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var showLocationDetails: Bool
    
    var annotation: MKPointAnnotation
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        let parent: MapView
        
        init(parent: MapView) {
            
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            
            parent.centerCoordinate = mapView.centerCoordinate
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            let identifier = "PhotoTag"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true // Shows pop up information.
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            guard let location = view.annotation as? MKPointAnnotation else { return }
            
            parent.showLocationDetails = true 
        }
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {

        view.addAnnotation(annotation)
    }
    
    func makeCoordinator() -> Coordinator {
        
        return Coordinator(parent: self)
    }
}

struct MapView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        
        return MapView(centerCoordinate: .constant(annotation.coordinate), showLocationDetails: .constant(false), annotation: annotation)
    }
}
