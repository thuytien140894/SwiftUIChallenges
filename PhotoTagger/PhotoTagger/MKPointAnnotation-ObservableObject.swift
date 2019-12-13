//
//  MKPointAnnotation-ObservableObject.swift
//  PhotoTagger
//
//  Created by Tien Thuy Ho on 1/18/20.
//  Copyright © 2020 Tien Thuy Ho. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    
    var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }

        set {
            title = newValue
        }
    }

    var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown value"
        }

        set {
            subtitle = newValue
        }
    }
}
