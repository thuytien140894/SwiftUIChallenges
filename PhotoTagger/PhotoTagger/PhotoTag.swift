//
//  PhotoTag.swift
//  PhotoTagger
//
//  Created by Tien Thuy Ho on 1/13/20.
//  Copyright © 2020 Tien Thuy Ho. All rights reserved.
//

import SwiftUI
import MapKit

class PhotoTag: Identifiable, Codable, ObservableObject {
    
    @Published var imageData: String?
    @Published var name = ""
    var location = CodableMKPointAnnotation()
    
    @Published var image: UIImage? {
        didSet {
            guard
                let newImage = image,
                let imageData = newImage.pngData()?.base64EncodedString() else { return }
            
            self.imageData = imageData
        }
    }
    
    private var uniqueID = UUID()
    var id: String {
        if let imageData = imageData {
            
            let startIndex = imageData.startIndex
            let endIndex = imageData.index(startIndex, offsetBy: 10)
            let imageHash = String(imageData[...endIndex])
            
            return name + imageHash
        }
        
        return uniqueID.uuidString
    }
    
    enum CodingKeys: CodingKey {
        case imageData
        case name
        case location
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        imageData = try container.decode(String.self, forKey: .imageData)
        name = try container.decode(String.self, forKey: .name)
        location = try container.decode(CodableMKPointAnnotation.self, forKey: .location)
        
        if let imageData = imageData,
            let decodedData = Data(base64Encoded: imageData, options: .ignoreUnknownCharacters) {
            
            image = UIImage(data: decodedData)
        }
        
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(imageData, forKey: .imageData)
        try container.encode(name, forKey: .name)
        try container.encode(location, forKey: .location)
    }
}
