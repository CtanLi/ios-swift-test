//
//  NotesViewController.swift
//  TestApp
//
//

import UIKit

protocol NotesView: class {
    func showNotes(notes: [Notes])
}

class NotesViewController: UIViewController, NotesView {

    // MARK: - Variables

    var presenter: INotesPresenter?

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        presenter?.fetchNotes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showNotes(notes: [Notes]) {
        print(notes)
    }
}

