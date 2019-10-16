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
    
    var book: Book? {
        didSet {
                updateViews()
            }
        }
    
    func updateViews() {
        if let book: Book = book{
            print(book.title)
                reasonsTextField.text = book.reasonToRead
            navigationItem.title = book.title
        } else {
            navigationItem.title = "Add new books"
        }
    }
    
    var bookController: BookController? 


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard let bookTitle = bookTextField.text, !bookTitle.isEmpty else { return }
        guard let reasons = reasonsTextField.text, !reasons.isEmpty else { return }
        
                
        bookController?.createBook(named: bookTitle, reasonToRead: reasons, hasBeenRead: false)
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
