//
//  EventService.swift
//  Riviera17
//

//

import Foundation

class EventService{

    func getEventDetails(callback: @escaping (NSDictionary) -> ()){
        request2(url: "https://riviera-2017-api.herokuapp.com/api/v1/events/all", callback: callback)
    }
    
    func request2(url:String, callback: @escaping (NSDictionary) -> ()){
        let nsURL = NSURL(string: url)
        
        if (try? Data(contentsOf: nsURL as! URL)) != nil{
        
        let task = URLSession.shared.dataTask(with: nsURL as! URL){
            (data,response,error) in
            
            
            do {
                let response = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                callback(response)
            } catch let error as NSError {
                print("error: \(error.localizedDescription)")
            }
        }
    
        task.resume()
        }
    }

    
    

}
