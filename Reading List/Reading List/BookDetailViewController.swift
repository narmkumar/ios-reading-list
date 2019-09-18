//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Niranjan Kumar on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol BookDetailDelegate {
    func bookUpdated(_ book: Book)
}

class BookDetailViewController: UIViewController {

    var book: Book?
    
    func updateViews() {
        if let book: Book = book{
            print(book.title)
                reasontoReadField.text = book.reasonToRead
            navigationItem.title = book.title
        } else {
            navigationItem.title = "Add new books"
        }
    }
    
    var bookController: BookController? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var reasontoReadField: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
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
