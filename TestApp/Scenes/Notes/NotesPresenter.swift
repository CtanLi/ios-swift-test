//
//  NotesPresenter.swift
//  TestApp
//
//

import Foundation

protocol INotesPresenter {
    func MockedNotes()
    func searchBy(text: String)
}

class NotesPresenter: INotesPresenter {

    private weak var view: NotesView?

    init(view: NotesView) {
        self.view = view
    }
    
    func MockedNotes() {
           DispatchQueue.main.async {
            self.view?.showNotes(notes: self.fetchMockNotes())
          }
      }
    
    func searchBy(text: String) {
        
    }
}

extension NotesPresenter {
    func fetchMockNotes() -> [Notes] {
          let referenceDate = Date()
        return (1...50).map {_ in
          Notes(text:  "There are a number of features that make RandomText a little different from other Lorem Ipsum dummy text generators you may find around the web....", date: Date(timeIntervalSinceReferenceDate: .random(in: 0...referenceDate.timeIntervalSinceReferenceDate))) }.sorted(by: {
                return $0.date > $1.date
          })
    }
}
