//
//  Note.swift
//  TestApp
//
//

import Foundation
import CoreData

@objc(Notes)
class Notes: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case text
        case date

    }

    // MARK: - Core Data Managed Object
    @NSManaged var text: String?
    @NSManaged var date: Date?

    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Notes", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
        self.date = try container.decodeIfPresent(Date.self, forKey: .date)
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
        try container.encode(date, forKey: .date)
    }
}

//class Note {
//    var text: String
//      var date: Date
//
//      init(text: String, date: Date) {
//          self.text = text
//          self.date = date
//      }
//}
