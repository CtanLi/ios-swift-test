//
//  NotesViewController.swift
//  TestApp
//
//

import UIKit

protocol NotesView: class {
    func showNotes(notes: [Notes])
}

class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NotesView {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var notes = [Notes]()
    var presenter: INotesPresenter?

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notes"
        presenter = NotesPresenter(view: self)
        presenter?.MockedNotes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func showNotes(notes: [Notes]) {
        print(notes)
        self.notes = notes
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell") as! NotesCell
        cell.noteText.text = notes[indexPath.row].text
        cell.noteDate.text = notes[indexPath.row].date.formatTodaysDate()
        return cell
    }
}

