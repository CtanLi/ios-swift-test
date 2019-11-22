//
//  AddNotesController.swift
//  TestApp
//
//  Created by CtanLI on 2019-11-22.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import UIKit

protocol AddNotesView: class {
    func dismissScreen()
}

class AddNotesController: UIViewController, AddNotesView {

    var presenter: INotesPresenter?
    
    @IBOutlet weak var noteDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NotesPresenter(view: nil, addView: self)
    }
    
    @IBAction func addNoteAction(_ sender: UIButton) {
        let word = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        let newDate = NSDate()
        let dict: [String: Any] = ["text": word, "date": newDate]
        presenter?.addNotes(dict: [dict as NSDictionary])
    }
    
    func dismissScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.navigationController?.popViewController(animated: true)
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
