//
//  CoreDataController.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 12.02.2023.
//

import Foundation
import CoreData

class CoreDataController {
    static var container: NSPersistentContainer {
        let container = NSPersistentContainer(name: "NetflixSwiftUIDataModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading core data", error.localizedDescription)
            }
        }
        return container
    }
}
