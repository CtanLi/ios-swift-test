//
//  NotesViewController.swift
//  TestApp
//
//

import UIKit

protocol NotesView: class {
    func showNotes(notes: [Notes])
    func deleteNotes(notes: [Notes])
}

class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating, NotesView, UpdateNotesTableViewDelegate {
  
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var unFilteredNotes = [Notes]()
    var noteToEdit = Notes()
    var presenter: INotesPresenter?
    var searchController = UISearchController(searchResultsController: nil)
    var filteredNotes: [Notes]?
    var isEditPressed = Bool()
    let addvcSegue = "addNotesSegue"

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notes"
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "What are you looking for?"
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            // Fallback on earlier versions
        }
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = .white
        searchController.searchBar.barTintColor = UIColor(red:0.20, green:0.58, blue:0.99, alpha:1.0)
        searchController.searchBar.searchBarStyle = .default
        searchController.searchBar.isTranslucent = false
        searchController.searchBar.tintColor = UIColor.black
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        presenter = NotesPresenter(view: self, addView: nil)
        presenter?.fetchNotes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func showNotes(notes: [Notes]) {
        unFilteredNotes = notes
        filteredNotes = notes
        tableView.reloadData()
    }
    
    func deleteNotes(notes: [Notes]) {
        
    }
    
    func reloadNotes() {
        presenter?.fetchNotes()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let fNotes = filteredNotes else {
            return 0
        }
        return fNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell") as! NotesCell
        if let fNotes = filteredNotes {
            cell.noteText.text = fNotes[indexPath.row].text
            cell.noteDate.text = fNotes[indexPath.row].date?.formatTodaysDate()
        }
        return cell
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredNotes = unFilteredNotes.filter { team in
                return (team.text?.lowercased().contains(searchText.lowercased()))!
            }
        } else {
            filteredNotes = unFilteredNotes
        }
        tableView.reloadData()
    }
    
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: addvcSegue, sender: self)
    }
}

extension NotesViewController {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") {action, next  in
            if let note = self.filteredNotes?[indexPath.row] {
                self.presenter?.deleteNotes(note: note)
                self.filteredNotes?.remove(at: indexPath.row)
                if #available(iOS 11.0, *) {
                    self.tableView.performBatchUpdates({
                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    }) { (finished) in
                        self.tableView.reloadData()
                    }
                } else {
                    // Fallback on earlier versions
                    self.tableView.beginUpdates()
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    self.tableView.endUpdates()
                }
            }
        }

        let editAction = UITableViewRowAction(style: .normal, title: "Edit") {action, next  in
            if let note = self.filteredNotes?[indexPath.row] {
                self.isEditPressed = true
                self.noteToEdit = note
                 self.filteredNotes?.remove(at: indexPath.row)
                self.performSegue(withIdentifier: self.addvcSegue, sender: self)
            }
        }
        return [deleteAction, editAction]
    }
    
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == addvcSegue) {
            let addNoteController = segue.destination as! AddNotesController
            addNoteController.delegate = self
            addNoteController.isEditPressed = isEditPressed
            addNoteController.noteToEdit = noteToEdit
            self.isEditPressed = false
        }
     }
}
