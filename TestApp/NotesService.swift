//
//  NotesService.swift
//  TestApp
//
//  Created by CtanLI on 2019-11-22.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation
import CoreData

class NotesService {
    static let shared = NotesService()

//    func fetchData(note: Notes, completion: @escaping ([Notes]) -> ()) {
//        let managedObjectContext = PersistanceService.context
//        let fetchRequest = NSFetchRequest<Notes>(entityName: "Notes")
//        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        do {
//            let notes = try managedObjectContext.fetch(fetchRequest)
//            completion(notes)
//        } catch let error {
//            print(error)
//        }
//    }
}
