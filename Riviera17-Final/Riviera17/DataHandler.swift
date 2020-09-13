//
//  DataHandler.swift
//  Riviera17
//

//

import Foundation
import UIKit

var enteredFormal = false
var eventsCollection = [EventDetails]()
var preRiviera1 = [EventDetails]()
var workshop = [EventDetails]()
var formal = [EventDetails]()
var informal = [EventDetails]()
var premium = [EventDetails]()
var adventureSports = [EventDetails]()
var messages = [Message]()
var localMessages = [Message]()
var recipient = "all"
var messageSaved = ""
var loginValue = false
var tokenStored = "nil"
var loggedInUser = ""
var RequestsCollection = [ChangeRequest]()
var requestPost = false
var requestID = ""
var errorDir = NSDictionary()
var WWTU = [EventDetails]()
var QE = [EventDetails]()
var WWH = [EventDetails]()
var Dance = [EventDetails]()
var ME = [EventDetails]()
var WWE = [EventDetails]()
var WWT = [EventDetails]()
var Drama = [EventDetails]()
var CE = [EventDetails]()


class DataHandler: UIViewController{
    
    func loadDetails(details: NSArray){
        for detail in details{
            let detail = detail as! NSDictionary
            let id = detail["_id"] as? String ?? "ID"
            let name = detail["event_name"] as? String ?? "Event_Name"
            let desc = detail["event_description"] as? String  ?? "Event_Description"
            let cat = detail["event_category"] as? String ?? "Event_Category"
            let rules = detail["event_rules"] as? String ?? "Event_Rules"
            let duration = detail["event_duration"] as? Int ?? 0
            let team = detail["event_team"] as? String ?? "Event_Team"
            let nop = detail["event_no_participants"] as? Int ?? 1
            let cond = detail["event_chapter"] as? String ?? "NA"
            let fees = detail["event_reg_fees"] as? Int ?? 0
            let ch_name = detail["event_chapter_name"] as? String ?? "NA"
            let subcat = detail["event_subcategory"] as? String ?? "Nil"
            
            let cods = detail["event_coordinators"] as! NSArray
            let cod1 = cods[0] as! NSDictionary
            let cod2 = cods[1] as! NSDictionary
            
            let cod1Name = cod1["name"] as! String
            let cod1Email = cod1["email"] as! String
            let cod1RegNo = cod1["reg_no"] as! String
            let cod1Phone = cod1["phone"] as! String
            
            let cod2Name = cod2["name"] as! String
            let cod2Email = cod2["email"] as! String
            let cod2RegNo = cod2["reg_no"] as! String
            let cod2Phone = cod2["phone"] as! String
            
            let newCreatedEvent = EventDetails(event_id: id,event_name: name,event_desc: desc,event_category: cat,event_rules: rules,duration: duration,team: team,nop: nop,conductedBy: cond,fees: fees,event_chapter_name: ch_name,event_subcategory: subcat,cod1Name: cod1Name,cod1RegNo: cod1RegNo,cod1Email: cod1Email,cod1Phone: cod1Phone,cod2Name: cod2Name,cod2RegNo: cod2RegNo,cod2Email: cod2Email,cod2Phone: cod2Phone)
            
            if newCreatedEvent.event_category == "Pre-Riviera" {
                preRiviera1.append(newCreatedEvent)
            }
            else if newCreatedEvent.event_category == "Workshop" {
                workshop.append(newCreatedEvent)
            }
            else if newCreatedEvent.event_category == "Formal" {
                if(newCreatedEvent.event_subcategory == "Words Worth Telugu"){
                    WWTU.append(newCreatedEvent)
                }
                else if(newCreatedEvent.event_subcategory == "Quiz Events"){
                    QE.append(newCreatedEvent)
                }
                else if(newCreatedEvent.event_subcategory == "Words Worth Hindi"){
                    WWH.append(newCreatedEvent)
                }
                else if(newCreatedEvent.event_subcategory == "Dance"){
                    Dance.append(newCreatedEvent)
                }
                else if(newCreatedEvent.event_subcategory == "Music Events"){
                    ME.append(newCreatedEvent)
                }
                else if(newCreatedEvent.event_subcategory == "Words Worth English"){
                    WWE.append(newCreatedEvent)
                }
                else if(newCreatedEvent.event_subcategory == "Words Worth Tamil"){
                    WWT.append(newCreatedEvent)
                }
                else if(newCreatedEvent.event_subcategory == "Drama"){
                    Drama.append(newCreatedEvent)
                }
                else if(newCreatedEvent.event_subcategory == "Cyber Engage"){
                    CE.append(newCreatedEvent)
                }
            }
            else if newCreatedEvent.event_category == "Informal" {
                informal.append(newCreatedEvent)
            }
            else if (newCreatedEvent.event_category == "Premium"){
                premium.append(newCreatedEvent)
            }
            if (newCreatedEvent.event_category == "Formal" && newCreatedEvent.event_subcategory == "Adventure Sports") {
                adventureSports.append(newCreatedEvent)
            }
            eventsCollection.append(newCreatedEvent)
        }//For Loop Ends Here
        print("Events Fetched")
        
    }//loadDetails Ends Here
    
}//Class Ends Here
