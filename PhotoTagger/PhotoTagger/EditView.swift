//
//  EditView.swift
//  PhotoTagger
//
//  Created by Tien Thuy Ho on 1/18/20.
//  Copyright © 2020 Tien Thuy Ho. All rights reserved.
//

import SwiftUI
import MapKit

struct EditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var location: MKPointAnnotation

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $location.wrappedTitle)
                    TextField("Description", text: $location.wrappedSubtitle)
                }
            }
            .navigationBarTitle("Edit Location")
            .navigationBarItems(trailing: Button("Done") {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: MKPointAnnotation())
    }
}
