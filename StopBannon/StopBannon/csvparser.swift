//
//  csvparser.swift
//  StopBannon
//
//  Created by Kathleen Lu on 11/19/16.
//  Copyright (c) 2016 Kyle Jablon. All rights reserved.
//

import Foundation

func parseCSV (contentsOfURL: NSURL, encoding: NSStringEncoding, error: NSErrorPointer) -> [(lastname:String, firstname:String, party: String, phone:String, state:String, position:String, denounced:String)]? {
    // Load the CSV file and parse it
    let delimiter = ","
    var items:[(lastname:String, firstname:String, party: String, phone:String, state:String, position:String, denounced:String)]?
    
    if let content = String(contentsOfURL: contentsOfURL, encoding: encoding, error: error) {
        items = []
        let lines:[String] = content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()) as [String]
        
        for line in lines {
            var values:[String] = []
            values = line.componentsSeparatedByString(delimiter)
            // Put the values into the tuple and add it to the items array
            let item = (lastname: values[0], firstname: values[1], party: values[2], phone: values[3], state: values[4], position: values[5], denounced: values[6])
            items?.append(item)
        }
    }
    
    return items
}


func preloadData () {
    // Retrieve data from the source file
    if let contentsOfURL = NSBundle.mainBundle().URLForResource("menudata", withExtension: "csv") {
        NSError* error = nil;
        if let items = parseCSV(contentsOfURL, NSUTF8StringEncoding, error: &error) {
            // Preload the menu items
            if let managedObjectContext = self.managedObjectContext {
                for item in items {
                    let menuItem = NSEntityDescription.insertNewObjectForEntityForName("MenuItem", inManagedObjectContext: managedObjectContext) as! MenuItem
                    menuItem.name = item.name
                    menuItem.detail = item.detail
                    menuItem.price = (item.price as NSString).doubleValue
                    
                    if managedObjectContext.save(&error) != true {
                        println("insert error: \(error!.localizedDescription)")
                    }
                }
            }
        }
    }
}
