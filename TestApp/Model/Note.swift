//
//  Note.swift
//  TestApp
//
//

import Foundation
import CoreData

@objc(Notes)
public class Notes: NSManagedObject {
    @NSManaged public var text: String?
    @NSManaged public var date: Date?
}

