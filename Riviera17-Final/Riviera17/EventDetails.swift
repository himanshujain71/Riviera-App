//
//  EventDetails.swift
//  Riviera17
//

//

import Foundation

class EventDetails{

    var event_id: String
    var event_name: String
    var event_desc: String
    var event_category: String
    var event_rules: String
    var duration: Int
    var team: String
    var nop: Int
    var conductedBy: String
    var fees: Int
    var event_chapter_name: String
    var event_subcategory: String
    
    var cod1Name: String
    var cod1RegNo: String
    var cod1Email: String
    var cod1Phone: String
    
    var cod2Name: String
    var cod2RegNo: String
    var cod2Email: String
    var cod2Phone: String
    
    init(event_id: String,event_name: String,event_desc: String,event_category: String,event_rules: String,duration: Int,team: String,nop: Int,conductedBy: String,fees: Int,event_chapter_name: String,event_subcategory: String,cod1Name: String,cod1RegNo: String,cod1Email: String,cod1Phone: String,cod2Name: String,cod2RegNo: String,cod2Email: String,cod2Phone: String){
        
        self.event_id = event_id
        self.event_name = event_name
        self.event_desc = event_desc
        self.event_category = event_category
        self.event_rules = event_rules
        self.duration = duration
        self.team = team
        self.nop = nop
        self.conductedBy = conductedBy
        self.fees = fees
        self.event_chapter_name = event_chapter_name
        self.event_subcategory = event_subcategory
        
        self.cod1Name = cod1Name
        self.cod1RegNo = cod1RegNo
        self.cod1Email = cod1Email
        self.cod1Phone = cod1Phone
        
        self.cod2Name = cod2Name
        self.cod2RegNo = cod2RegNo
        self.cod2Email = cod2Email
        self.cod2Phone = cod2Phone
        
    }
    
}
