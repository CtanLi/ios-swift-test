//
//  NotesPresenter.swift
//  TestApp
//
//

import Foundation

protocol INotesPresenter {
    func fetchNotes()
    func searchBy(text: String)
}

class NotesPresenter: INotesPresenter {
    
    private weak var view: NotesView?

    init(view: NotesView) {
        self.view = view
    }
    
    func fetchNotes() {
//        NotesService.shared.fetchData(note: ) { (notes) in
//            
//            DispatchQueue.main.async {
//                self.view?.showNotes(notes: notes)
//            }
//        }
    }
    
    func searchBy(text: String) {
        
    }
}
