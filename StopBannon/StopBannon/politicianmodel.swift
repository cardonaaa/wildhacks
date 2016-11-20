//
//  politicianmodel.swift
//  StopBannon
//
//  Created by Kathleen Lu on 11/19/16.
//  Copyright (c) 2016 Kyle Jablon. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataController: NSObject {
    var managedObjectContext: NSManagedObjectContext
    override init() {
        var error:NSError? = nil
        // This resource is the same name as your xcdatamodeld contained in your project.
        if let modelURL = Bundle.main.url(forResource: "DataModel", withExtension:"momd") {
            if let mom = NSManagedObjectModel(contentsOf: modelURL) {
                let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
                managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
                managedObjectContext.persistentStoreCoordinator = psc
                DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background).async {
                    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                    let docURL = urls[urls.endIndex-1]
                    /* The directory the application uses to store the Core Data store file.
                    This code uses a file named "DataModel.sqlite" in the application's documents directory.
                    */
                    let storeURL = docURL.appendingPathComponent("DataModel.sqlite")
                    psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil, error: &error)
                }
            } else {
                fatalError("Error initializing mom from: \(modelURL)")
            }
            
        } else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        
    }
}
