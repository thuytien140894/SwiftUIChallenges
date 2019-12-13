//
//  ContentView.swift
//  PhotoTagger
//
//  Created by Tien Thuy Ho on 12/9/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var photoTags: [PhotoTag] = []
    @State var showImagePicker = false
    @State var dataIsLoaded = false
    
    var body: some View {
        NavigationView {
            List(photoTags, id: \.id) { photoTag in
                NavigationLink(destination: DetailView(photoTag: photoTag)) {
                    if photoTag.image != nil {
                        Image(uiImage: photoTag.image!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    }
                    Text(photoTag.name)
                }
            }
            .navigationBarTitle("Photo Tagger")
            .navigationBarItems(trailing:
                Button(action: {
                    let newPhotoTag = PhotoTag()
                    self.photoTags.append(newPhotoTag)
                    self.showImagePicker = true
                }) {
                    Image(systemName: "plus")
                }
            )
                .sheet(isPresented: $showImagePicker, onDismiss: saveData) {
                    NavigationView {
                        DetailView(photoTag: self.photoTags.last!)
                            .navigationBarItems(trailing: Button("Save") {
                                self.showImagePicker = false
                            })
                    }
            }
            .onAppear(perform: loadData)
        }
    }
    
    private func saveData() {
        
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPhotoTags")
            let data = try JSONEncoder().encode(photoTags)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    private func loadData() {
        
        guard !dataIsLoaded else {
            saveData()
            return
        }
        
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPhotoTags")
        do {
            let data = try Data(contentsOf: filename)
            photoTags = try JSONDecoder().decode([PhotoTag].self, from: data)
            dataIsLoaded = true
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
