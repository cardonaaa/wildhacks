//
//  Politician+CoreDataProperties.swift
//  stopBannon2
//
//  Created by Kyle Jablon on 11/19/16.
//  Copyright © 2016 Kyle Jablon. All rights reserved.
//

import Foundation
import CoreData


extension Politician {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Politician> {
        return NSFetchRequest<Politician>(entityName: "Politician");
    }

    @NSManaged public var firstname: String?
    @NSManaged public var lastname: String?
    @NSManaged public var phone: String?
    @NSManaged public var party: String?
    @NSManaged public var position: String?
    @NSManaged public var state: String?
    @NSManaged public var denounced: Bool

}
