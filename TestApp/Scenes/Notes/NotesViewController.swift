//
//  NotesViewController.swift
//  TestApp
//
//

import UIKit

protocol NotesView: class {
    func showNotes(notes: [Notes])
}

class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating, NotesView {

    
   
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var unFilteredNotes = [Notes]()
    var presenter: INotesPresenter?
    var searchController = UISearchController(searchResultsController: nil)
    var filteredNotes: [Notes]?
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

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          if searchController.isActive && searchController.searchBar.text != "" {
            
        }
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

