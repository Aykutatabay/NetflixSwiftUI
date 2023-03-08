//
//  DownloadViewModel.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 11.02.2023.
//

import Foundation
import SwiftUI
import CoreData

class DownloadViewModel: ObservableObject {

    private let entityName: String = "TitleItem"
    
    @Published var savedTitles: [TitleItem] = []
    
    let container = NSPersistentContainer(name: "NetflixSwiftUIDataModel")
    
    
    
    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading core data", error.localizedDescription)
            }
        }
    }
    
     func getTitles() {
        let request = NSFetchRequest<TitleItem>(entityName: entityName)
        
        do {
            savedTitles = try container.viewContext.fetch(request)
            print("Successfully fetched")
            print(savedTitles)
        } catch let error {
            print("Error fetching entities", error.localizedDescription)
        }
    }
    
     func addItems(title: Title) {
        
         print("core data pre")
         let item = TitleItem(context: container.viewContext)
        
         print("core data")
        item.id = Int64(title.id)
        item.original_name = title.original_name ?? "Unknown"
        item.original_title = title.original_title ?? "Unknown"
        item.vote_average = title.vote_average
        item.vote_count = Int64(title.vote_count)
        item.media_type = title.media_type
        item.overview = title.overview
        item.release_date = title.release_date
        
        print(item.id)
        applyChanges()
    }
    
     func removeTitle(title: Title) {
         
         if let entity = savedTitles.first(where: { $0.id == title.id}) {
             container.viewContext.delete(entity)
             print(entity.original_title ?? entity.original_name, "Deleted")
             applyChanges()
         } else {
             
         }

    }
    
    private func save() {
        
        do {
            try container.viewContext.save()
            print("successfully saved")
        } catch let error {
            print("Failed to save title", error.localizedDescription)
        }
    }
    private func applyChanges() {
        save()
        getTitles()
    }
    

}


