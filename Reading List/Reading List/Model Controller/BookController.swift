//
//  BookController.swift
//  Reading List
//
//  Created by Niranjan Kumar on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


class BookController {
    
  private(set) var books: [Book] = []
    
    // go over this
    var readBooks: [Book] {
        books.filter() {$0.hasBeenRead}

    }

    // go over this
    var unreadBooks: [Book] {
        books.filter() {!$0.hasBeenRead}

    }
    
    
    func createBook(named name: String, reasonToRead reason: String, hasBeenRead read: Bool) {
        let newBook = Book(title: name, reasonToRead: reason, hasBeenRead: read)
        books.append(newBook)
        saveToPersistentStore()
    }
    
    // can index equal any "location" of book in the array? rather than just first index?
    func deleteBook(_ book: Book) {
        if let index = books.firstIndex(of: book) {
            books.remove(at: index)
            saveToPersistentStore()
        }
        
    }
    
    // go over this
    func updateHasBeenRead(for book: Book) {
        if let index = books.firstIndex(of: book) {
            var book = books[index]
            book.hasBeenRead.toggle()
            books[index] = book
            saveToPersistentStore()
        }
 
    }
    
    // go over this
    func editBook(for book: Book) {
        
    }
    
    
    // MARK: - Persistence

    private var readingListURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("ReadingList.plist")
    }
    
    private func saveToPersistentStore() {
        guard let url = readingListURL else { return }

        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error loading book data: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        guard let url = readingListURL else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch  {
            print("Error loading books data: \(error)")
        }
        
    }
}
