//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Niranjan Kumar on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    let bookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    


    // MARK: - Table view data source
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
        return bookController.readBooks.count
        } else if section == 1 {
            return bookController.unreadBooks.count
        } else { return 0 }
        // check above method later
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        
        guard let bookCell = cell as? BookTableViewCell else { return cell }
        bookCell.book = bookFor(indexPath: indexPath)
        bookCell.delegate = self
 
        return cell
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            bookController.deleteBook(book: bookFor(indexPath: indexPath))
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
     
     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title: String
        if section == 0 {
            title = "Read books"
        } else {
            title = "Unread books"
        }
        return title
    }

     
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookSegue" {
            if let bookDetailVC = segue.destination as? BookDetailViewController {
                bookDetailVC.bookController = bookController
            }
        } else if segue.identifier == "BookDetailSegue" {
            if let bookDetailVC = segue.destination as? BookDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                bookDetailVC.book = bookFor(indexPath: indexPath)
                bookDetailVC.bookController = bookController
                }
                
            }
        }
    
}


extension ReadingListTableViewController: BookTableViewCellDelegate {

    func toggleHasBeenRead(for cell: BookTableViewCell) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    let book = bookFor(indexPath: indexPath)
    bookController.updateHasBeenRead(for: book)
    tableView.reloadData()
}
}
