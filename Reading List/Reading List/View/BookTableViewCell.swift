//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Niranjan Kumar on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    
    var book: Book? {
        didSet { // look up didSet functionality again
            updateViews()
        }
    }
    
    var delegate: BookTableViewCellDelegate?
    
    //'weak' (var) must not be applied to non-class-bound 'BookTableViewCellDelegate'; consider adding a protocol conformance that has a class bound
    

    @IBAction func hasBeenReadTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    
    func updateViews() {
        guard let book = book else { return }
        
        bookTitle.text = book.title
        // setImage.(UIimage) method helps pull the images from your assets to different options (what are image literals)
        if book.hasBeenRead {
            hasBeenReadButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            hasBeenReadButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    
    
    
    }
    
    
}
