//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Niranjan Kumar on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookTextField: UITextField!
    
    @IBOutlet weak var reasonsTextField: UITextView!
    
    var book: Book?
    
    var bookController: BookController?

    
    func updateViews() {
        guard let title = book?.title, let reason = book?.reasonToRead else { return }
        
            reasonsTextField.text = reason
            navigationItem.title = title
            bookTextField.text = title
    
//            navigationItem.title = "Add new books"
        }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard let bookTitle = bookTextField.text, !bookTitle.isEmpty ,
              let reasons = reasonsTextField.text, !reasons.isEmpty else { return }
        
        if let book = book {
            bookController?.updateHasBeenRead(for: book)
        } else {
            bookController?.createBook(named: bookTitle, reasonToRead: reasons, hasBeenRead: false)
        }
            navigationController?.popViewController(animated: true)

        
        
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
