//
//  DetailView.swift
//  PhotoTagger
//
//  Created by Tien Thuy Ho on 12/10/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import SwiftUI
import MapKit

fileprivate enum SheetType {
    case imagePicker, editView
}

struct DetailView: View {
    
    @ObservedObject var photoTag: PhotoTag
    
    @State private var showImagePicker = false
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var showLocationDetails = false
    @State private var showSheet = false
    @State private var sheet: SheetType = .imagePicker
    
    private let locationFetcher = LocationFetcher()
    
    var body: some View {
        VStack {
            TextField("Pick a name", text: $photoTag.name)
                .frame(width: 200, height: 25, alignment: .center)
                .multilineTextAlignment(.center)
                .font(.headline)
            
            ZStack {
                Rectangle()
                    .fill(Color.secondary)
                
                if photoTag.image != nil {
                    Image(uiImage: photoTag.image!)
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            .onTapGesture {
                self.showSheet = true
                self.sheet = .imagePicker
            }
            
            ZStack {
                MapView(centerCoordinate: $centerCoordinate, showLocationDetails: $showLocationDetails, annotation: photoTag.location)
                Circle()
                    .fill(Color.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
            }
            .alert(isPresented: $showLocationDetails) {
                Alert(title: Text(photoTag.location.title ?? "Unknown"), message: Text(photoTag.location.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {

                    self.showSheet = true
                    self.sheet = .editView
                })
            }
        }
        .sheet(isPresented: $showSheet, onDismiss: updateLocation) {
            if self.sheet == .imagePicker {
                ImagePicker(image: self.$photoTag.image)
            } else {
                EditView(location: self.photoTag.location)
            }
        }
        .padding([.horizontal, .bottom])
        .navigationBarTitle("Detail View")
        .onAppear(perform: startLocationTracking)
    }
    
    private func updateLocation() {
        
        photoTag.location.coordinate = locationFetcher.lastKnownLocation ?? centerCoordinate
        photoTag.location.title = photoTag.location.title ?? "Location"
        photoTag.location.subtitle = photoTag.location.subtitle ?? "Description"
    }
    
    private func startLocationTracking() {
        
        locationFetcher.start()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(photoTag: PhotoTag())
    }
}
