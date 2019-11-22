//
//  NotesPresenter.swift
//  TestApp
//
//

import Foundation

protocol INotesPresenter {
    func fetchNotes()
    func addNotes(dict: [NSDictionary])
    func editNote(note: Notes)
    func deleteNotes(note: Notes)
}

class NotesPresenter: INotesPresenter {

    private weak var view: NotesView?
    private weak var addView: AddNotesView?
    
    init(view: NotesView?, addView: AddNotesView?) {
        self.view = view
        self.addView = addView
    }
    
    func fetchNotes() {
          NotesService.shared.fetchData { (notes) in
               DispatchQueue.main.async {
                 self.view?.showNotes(notes: notes)
             }
          }
      }
      
    func addNotes(dict: [NSDictionary]) {
        NotesService.shared.addData(dict: dict) { 
            self.addView?.dismissScreen()
       }
    }
    
    func editNote(note: Notes) {
        NotesService.shared.editNotes(note: note) {
            self.addView?.dismissScreen()
        }
    }
    
    func deleteNotes(note: Notes) {
        NotesService.shared.deleteNotes(note: note) {
            self.addView?.dismissScreen()
        }
    }
}

