//
//  ChangeRequest.swift
//  Riviera17
//

//

import Foundation

class ChangeRequest{
    var changeID: String
    var changedEventName: String
    var changedEventDescription: String
    var changedEventRules: String
//    var changedEventPrice: String
    var approvalStatus: String
    
    init(changeID: String, changedEventName: String,changedEventDescription: String,changedEventRules: String, approvalStatus: String){
        self.changeID = changeID
        self.changedEventName = changedEventName
//        self.changedEventPrice = changedEventPrice
        self.changedEventRules = changedEventRules
        self.changedEventDescription = changedEventDescription
        self.approvalStatus = approvalStatus
    }
    
}
