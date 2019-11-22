//
//  NotesPresenter.swift
//  TestApp
//
//

import Foundation

protocol INotesPresenter {
    func fetchNotes()
    func addNotes(dict: [NSDictionary])
    func searchBy(text: String)
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
    
    func searchBy(text: String) {
        
    }
}

