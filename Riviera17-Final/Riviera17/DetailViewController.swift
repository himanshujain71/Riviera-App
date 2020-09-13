//
//  DetailViewController.swift
//  Riviera17
//

//

import UIKit
import Alamofire

class DetailViewController: UIViewController {

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var eventNameLabel: UITextView!
    @IBOutlet weak var eventFeeLabel: UITextView!
    @IBOutlet weak var eventCatLabel: UILabel!
    @IBOutlet weak var eventDescLabel: UITextView!
    @IBOutlet weak var eventRulesLabel: UITextView!
    @IBOutlet weak var eventChapLabel: UILabel!
    
    var eventIDReceived = ""
    var eventNameRecevied = ""
    var chapterNameReceived = ""
    var categoryReceived = ""
    var descReceived = ""
    var rulesReceived = ""
    var feeReceived = 0
    

    @IBAction func sendForVerification(_ sender: AnyObject) {
                    let someCharacter: Character = "z"
                    switch someCharacter {
                    case "z":
                        self.makePostRequest(token: tokenStored)
                    default:
                        print("Some other character")
    }
        let alert = UIAlertController(title: "Success", message: "Request sent successfully for verification", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {(UIAlertAction) -> Void in
            self.performSegue(withIdentifier: "detailToHome", sender: self)
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func makePostRequest(token: String){
        
        let parameters: Parameters = [
            "eventId": eventIDReceived,
            "changes": [["changeField": "event_name", "changeValue": "\(self.eventNameLabel.text as! String)"], ["changeField":"event_description", "changeValue":"\(self.eventDescLabel.text as! String)"], ["changeField":"event_rules", "changeValue":"\(self.eventRulesLabel.text as! String)"]]
        ]
        
        let headers: HTTPHeaders = [
            "auth-token": "\(token)"
            
        ]
        
        // Both calls are equivalent
        Alamofire.request("https://riviera-2017-api.herokuapp.com/api/v1/requests", method: .post, parameters: parameters,  encoding: JSONEncoding.default , headers:headers ).responseJSON { response in debugPrint(response)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.title = "Event Details"
        
        eventNameLabel.text = eventNameRecevied
        eventChapLabel.text = chapterNameReceived
        eventCatLabel.text = categoryReceived
        
        eventDescLabel.text = descReceived
        eventDescLabel.scrollRangeToVisible(NSMakeRange(0, 0))
        eventDescLabel.setContentOffset(CGPoint.zero, animated: false)
        eventDescLabel.layer.cornerRadius = 4
        eventDescLabel.layer.opacity = 0.7
        
        eventRulesLabel.text = rulesReceived
        eventRulesLabel.layer.cornerRadius = 4
        eventRulesLabel.layer.opacity = 0.7
        
        eventFeeLabel.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        eventFeeLabel.text = "\(feeReceived)"
        eventFeeLabel.layer.cornerRadius = 4
        eventFeeLabel.layer.opacity = 0.7
        
        if loginValue == true {
            eventNameLabel.isEditable = true
            eventDescLabel.isEditable = true
            eventFeeLabel.isEditable = false
            eventRulesLabel.isEditable = true
            sendButton.isUserInteractionEnabled = true
            sendButton.alpha = 1.0
        }
        
        else if loginValue == false {
            eventNameLabel.isEditable = false
            eventRulesLabel.isEditable = false
            eventDescLabel.isEditable = false
            eventFeeLabel.isEditable = false
            sendButton.isUserInteractionEnabled = false
            sendButton.alpha = 0.0
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.eventDescLabel.setContentOffset(CGPoint.zero, animated: false)
        self.eventRulesLabel.setContentOffset(CGPoint.zero, animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.eventRulesLabel.resignFirstResponder()
        self.eventNameLabel.resignFirstResponder()
        self.eventDescLabel.resignFirstResponder()
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
