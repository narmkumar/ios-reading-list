//
//  BookController.swift
//  Reading List
//
//  Created by Niranjan Kumar on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    private(set) var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    /// Need help
    
     var readBooks: [Book] {
    }
    
    var unreadbooks: [Book] {
        
    }
    
    /// Need help
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving reading list data: \(error)")
        }
        
    }
    
    
    func loadFromPersistentStore() {
        do {
            let fileManager = FileManager.default
            guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else { return }
           let booksData = try Data(contentsOf: url)
            let decodeBooks = PropertyListDecoder()
            books = try decodeBooks.decode([Book].self, from: booksData)
        } catch  {
            print("Error loading books data: \(error)")
        }
    
    }
    
    @discardableResult func createBook(bookTitle title: String, reason reasonToRead: String, read hasBeenRead: Bool = false) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }

}
