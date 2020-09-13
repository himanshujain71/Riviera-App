//
//  Message.swift
//  Riviera17
//

//

import Foundation

class Message{
    var sender: String
    var username: String
    var text: String
    
    init(sender: String, username: String, text: String){
        self.sender = sender
        self.username = username
        self.text = text
    }
}
