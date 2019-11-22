//
//  AddNotesController.swift
//  TestApp
//
//  Created by CtanLI on 2019-11-22.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import UIKit
import CoreData

protocol AddNotesView: class {
    func dismissScreen()
}

protocol UpdateNotesTableViewDelegate: class {
    func reloadNotes()
}

class AddNotesController: UIViewController, AddNotesView {

    var presenter: INotesPresenter?
    var noteToEdit: Notes?
    var newDate = Date()
    var isEditPressed = Bool()
    weak var delegate: UpdateNotesTableViewDelegate?
    
    @IBOutlet weak var noteDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NotesPresenter(view: nil, addView: self)
        if isEditPressed {
            noteDescription.text = noteToEdit?.text
        }
    }

    func addNote() {
        let dict: [String: Any] = ["text": noteDescription.text ?? "", "date": newDate]
        presenter?.addNotes(dict: [dict as NSDictionary])
    }
    
    func updateNotes() {
        if let noteToEdit = noteToEdit {
            noteToEdit.text = noteDescription.text
            noteToEdit.date = newDate
            presenter?.editNote(note: noteToEdit)
        }
    }
    
    @IBAction func addNoteAction(_ sender: UIButton) {
        isEditPressed ? updateNotes() : addNote()
    }
    
    func dismissScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.delegate?.reloadNotes()
            self.navigationController?.popViewController(animated: true)
        })
    }
}
