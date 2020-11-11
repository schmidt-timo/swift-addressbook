//
//  AddressBook.swift
//  iOS3-Lencer-Schmidt
//
//  Created by Marie on 11.11.20.
//

import Foundation

class AddressBook: Codable {
    
    var addressCards: [AddressCard]
    
    init() {
        addressCards = []
    }
    
    func add(card: AddressCard) {
        addressCards.append(card)
    }
    
    func remove(card: AddressCard){
        let index = addressCards.firstIndex(of: card)
        if let _index = index {
            for i in addressCards {
                i.remove(friend: card)
            }
            addressCards.remove(at: _index)
        }
    }
    
    func sort() {
        addressCards.sort { (card1, card2) -> Bool in
            return card1.nachname < card2.nachname
        }
    }
    
    func save(toFile path: String) {
        let url = URL(fileURLWithPath: path)
        let encoder = PropertyListEncoder()
        if let data = try? encoder.encode(self) {
            try? data.write(to: url)
        }
    }
    
    class func addressBook(fromFile path: String) -> AddressBook? {
        let url = URL(fileURLWithPath: path)
        var result : AddressBook? = nil
        if let data = try? Data(contentsOf: url) {
            let decoder = PropertyListDecoder()
            if let addressbook = try? decoder.decode(self, from: data) {
                result = addressbook
            }
        }
        return result
    }
    
}
