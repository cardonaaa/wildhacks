//
//  csvparser.swift
//  StopBannon
//
//  Created by Kathleen Lu on 11/19/16.
//  Copyright (c) 2016 Kyle Jablon. All rights reserved.
//

import Foundation

class CSVParser {
    func parseCSV () -> [Politician]? {
        let csvURL = NSURL(string: "politicians.csv")!
        let delimiter = ","
        var items:[Politician]?
        
        if let content = String(contentsOfURL: csvURL, encoding: NSUTF8StringEncoding) {
            items = []
            let lines:[String] = content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()) as [String]
            
            for line in lines {
                var values:[String] = []
                values = line.componentsSeparatedByString(delimiter)
                // firstname, lastname, phone, position, state, party
                let item = Politician(firstname: values[1], lastname: values[0], phone: values[3], position: values[5], state: values[4], party: values[2])
                println(item)
                items?.append(item)
            }
        }
        return items
    }
}

var filePath = NSBundle.mainBundle().pathForResource("politicians", ofType: "csv")
let csvURL = NSURL(string: "politicians.csv")!
var error: NSErrorPointer = nil
//let csv = CSwiftV(contentsOfURL: csvURL, error: error)
CSVParser.parseCSV(csvURL)
