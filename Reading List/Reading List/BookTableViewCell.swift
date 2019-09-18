//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Niranjan Kumar on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }

    var delegate: BookTableViewCellDelegate?
    // 'weak' must not be applied to non-class-bound 'BookTableViewCellDelegate'; consider adding a protocol conformance that has a class bound
        // error message received when making delegate a weak variable
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    
    // how do you use the image literals here?
    private func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        if book.hasBeenRead {
            buttonLabel.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            buttonLabel.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    
    }

}
