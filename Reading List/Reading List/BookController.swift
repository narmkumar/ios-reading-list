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
    
    /// For the .filter higher order function "$0" calls the first input parameter (a way to loop over arrays and dictionaries)
    
     var readBooks: [Book] {
        return books.filter{ $0.hasBeenRead}
    }
    
    var unreadBooks: [Book] {
        return books.filter { !$0.hasBeenRead }
    }
    
    var delegate: ReadingListTableViewController?

    //
    
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
        let fileManager = FileManager.default
        guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else { return }
        do {
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
    
    func deleteBook(book: Book) {
        if let index = books.firstIndex(of: book) {
            books.remove(at: index)
        }
        saveToPersistentStore()
    }

    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.index(of: book) else { return }
        books[index].hasBeenRead.toggle()
        }
        
    
    // this update book takes the var newBook and assigns it to the values from the books array, the title and reason to read being the main updates
    func updateBook(book: Book, newTitle: String, newReasontoRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        var newBook = books[index]
        newBook.title = newTitle
        newBook.reasonToRead = newReasontoRead
        books[index] = newBook
        }
}
