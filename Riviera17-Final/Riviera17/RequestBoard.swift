//
//  RequestBoard.swift
//  Riviera17
//

//

import UIKit
import Alamofire

class RequestBoard: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hamburgerButton: UIBarButtonItem!
    
    func makePutRequest(token: String){
        
        let parameters: Parameters = [
            "requestId": "\(requestID)",
            "accept": requestPost
        ]
        
        let headers: HTTPHeaders = [
            "auth-token": "\(token)"
            
        ]
        
        // Both calls are equivalent
        Alamofire.request("https://riviera-2017-api.herokuapp.com/api/v1/requests", method: .put, parameters: parameters,  encoding: JSONEncoding.default , headers:headers ).responseJSON { response in debugPrint(response)
        }
        
    }
    
    func makeGetRequest(token: String){
        let url : String = "https://riviera-2017-api.herokuapp.com/api/v1/requests"
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = NSURL(string: url) as URL?
        
        request.httpMethod = "GET"
        request.addValue("\(token)", forHTTPHeaderField: "auth-token")
        request.timeoutInterval = 60
        
        
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue(), completionHandler:{ (response, data, error) -> Void in
//            var error: AutoreleasingUnsafeMutablePointer<NSError?>? = nil
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject] {
                    let requestArray = jsonResult["data"] as! NSArray
                    for request in requestArray{
                        let request = request as! NSDictionary
                        let changeID = request["_id"] as! String
                        let changesCol = request["changes"] as! [NSDictionary]
                        let approvalCol = request["approved"] as! NSDictionary
                        var approval = ""
                        if approvalCol["approvalStatus"] as? Bool == false{
                            approval = "0"
                        }
                        else if approvalCol["approvalStatus"] as? Bool == true {
                            approval = "1"
                        }
                        else {
                            approval = "2"
                        }
                        
                        var changedName = ""
                        var changedDesc = ""
                        var changedRules = ""
                        for item in changesCol{
                            if ((item["changeField"] as! String) == "event_name") {
                                changedName = item["changeValue"] as! String
                            }
                            else if ((item["changeField"] as! String) == "event_description") {
                                changedDesc = item["changeValue"] as! String
                            }
                            else if ((item["changeField"] as! String) == "event_rules") {
                                changedRules = item["changeValue"] as! String
                            }
                        }
                        let changedEvent = ChangeRequest(changeID: changeID ,changedEventName: changedName, changedEventDescription: changedDesc, changedEventRules: changedRules, approvalStatus: approval)
                        RequestsCollection.insert(changedEvent, at: 0)
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            self.tableView.reloadData()
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        if self.revealViewController() != nil {
            self.hamburgerButton.target = self.revealViewController()
            self.hamburgerButton.action = Selector("revealToggle:")
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        if loginValue == true && loggedInUser == "a"{
        self.makeGetRequest(token: tokenStored)
        }
        else{
            let alertView = UIAlertController(title: "Error", message: "Administrator not logged in!", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: {
            (UIAlertAction) in self.performSegue(withIdentifier: "requestToHome", sender: self)
            })
            alertView.addAction(dismissAction)
            DispatchQueue.main.async {
                self.present(alertView, animated: true, completion: nil)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RequestsCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RequestBoardCell
        
        cell.eventNameLabel.text = RequestsCollection[indexPath.row].changedEventName
        cell.eventDescLabel.text = RequestsCollection[indexPath.row].changedEventDescription
        cell.eventRulesLabel.text = RequestsCollection[indexPath.row].changedEventRules
        
        if RequestsCollection[indexPath.row].approvalStatus == "0" {
            cell.statusLabel.text = "Declined"
        }
        else if RequestsCollection[indexPath.row].approvalStatus == "1"{
            cell.statusLabel.text = "Approved"
        }
        else if RequestsCollection[indexPath.row].approvalStatus == "2"{
            cell.statusLabel.text = "Not Approved"
        }
        
        cell.eventDescLabel.layer.borderColor = UIColor.gray.cgColor
        cell.eventDescLabel.layer.borderWidth = 0.5
        cell.eventRulesLabel.layer.borderWidth = 0.5
        cell.eventRulesLabel.layer.borderColor = UIColor.gray.cgColor
        cell.eventRulesLabel.allowsEditingTextAttributes = false
        cell.eventDescLabel.allowsEditingTextAttributes = false
        cell.eventNameLabel.allowsEditingTextAttributes = false
        
     return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        let approveAction = UIAlertAction(title: "Approve", style: .default, handler: {(UIAlertAction) -> Void in
            requestPost = true
            requestID = RequestsCollection[indexPath.row].changeID
            self.makePutRequest(token: tokenStored)
            self.performSegue(withIdentifier: "requestToHome", sender: self)
        })
        let declineAction = UIAlertAction(title: "Decline", style: .default, handler: {(UIAlertAction) -> Void in
            requestPost = false
            requestID = RequestsCollection[indexPath.row].changeID
            self.makePutRequest(token: tokenStored)
            self.performSegue(withIdentifier: "requestToHome", sender: self)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(approveAction)
        actionSheet.addAction(declineAction)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
