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
    func fetchData(completion: @escaping ([Notes]) -> ()) {
        let managedObjectContext = PersistanceService.context
        let fetchRequest = NSFetchRequest<Notes>(entityName: "Notes")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let notes = try managedObjectContext.fetch(fetchRequest)
            completion(notes)
        } catch let error {
            print(error)
        }
    }
    
    func addData(dict: [NSDictionary], completion: @escaping () -> Void) {
        let user = Notes(context: PersistanceService.context)
        for dictionary in dict {
            if let newText = dictionary["text"]  {
                user.text = newText as? String
            }
            if let date = dictionary["date"] {
                user.date = date as? Date
            }
        }
        PersistanceService.saveContext()
        completion()
    }
    
    func editNotes(note: Notes, completion: @escaping () -> Void) {
        let managedObjectContext = PersistanceService.context
        let fetchRequest = NSFetchRequest<Notes>(entityName: "Notes")
        fetchRequest.predicate = NSPredicate(format: "text = %@", note.text ?? "")
        do {
            let notes = try managedObjectContext.fetch(fetchRequest)
            let noteToUpdate = notes[0] as NSManagedObject
            noteToUpdate.setValue(note.text, forKey: "text")
            noteToUpdate.setValue(note.date, forKey: "date")
            PersistanceService.saveContext()
            completion()
        } catch let error {
           print(error)
        }
    }
    
    func deleteNotes(note: Notes, completion: @escaping () -> Void) {
        let managedObjectContext = PersistanceService.context
        let fetchRequest = NSFetchRequest<Notes>(entityName: "Notes")
        fetchRequest.predicate = NSPredicate(format: "text = %@", note.text ?? "")
        do {
           let notes = try managedObjectContext.fetch(fetchRequest)
           let noteToUpdate = notes[0] as NSManagedObject
           PersistanceService.delete(noteToUpdate)
           PersistanceService.saveContext()
           completion()
        } catch let error {
          print(error)
        }
    }
}
