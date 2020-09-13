//
//  MessageBoard.swift
//  Riviera17
//

//

import UIKit
import SWRevealViewController

class MessageBoard: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var sendButtonOutlet: UIButton!
    @IBOutlet weak var hamburgerButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var messageTimer: Timer!
    
    @IBAction func unwindToList(segue: UIStoryboardSegue){
    }
    
    @IBAction func sendAction(_ sender: AnyObject) {
        if textField.text != ""{
        messageSaved = self.textField.text!
        let alertController = UIAlertController(title: "Select Recipient", message: "Send to ?", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "All", style: .cancel, handler: {
        UIAlertAction in
            recipient = "all"
            self.sendMessage()
            }
        )
        alertController.addAction(defaultAction)
        
        let select = UIAlertAction(title: "Event", style: .default, handler: {
            UIAlertAction in
            self.performSegue(withIdentifier: "ChooseRecipient", sender: self)
        })
        alertController.addAction(select)
        
        
        self.present(alertController, animated: true, completion: nil)
        self.textField.text = ""
            self.textField.resignFirstResponder()}
            
        else if textField.text == ""{
        let alert = UIAlertController(title: "Invalid", message: "Please enter a message", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        if self.revealViewController() != nil {
            self.hamburgerButton.target = self.revealViewController()
            self.hamburgerButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.tableView.separatorColor = UIColor.clear
        self.tableView.layer.backgroundColor = UIColor.clear.cgColor
        self.tableView.layer.cornerRadius = 4
        
        self.view2.layer.borderWidth = 2
        self.view2.layer.borderColor = UIColor.white.cgColor
        self.view2.layer.cornerRadius = 5
        
        if loginValue != false {
        getMessages()
        messageTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(getMessages), userInfo: nil, repeats: true)
        }
            
        else {
            self.textField.alpha = 0
            sendButtonOutlet.alpha = 0
            let alertView = UIAlertController(title: "Error", message: "User not logged in!", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: {(UIAlertAction) in
            self.performSegue(withIdentifier: "messageToHome", sender: self)
            })
            alertView.addAction(dismissAction)
            DispatchQueue.main.async {
                self.present(alertView, animated: true, completion: nil)
            }
        }
        self.automaticallyAdjustsScrollViewInsets = false;

        // Do any additional setup after loading the view.
    }
    
    func getMessages(){
        self.makeGetRequest(token: tokenStored)
        self.tableView.reloadData()

    }
    
    func makeGetRequest(token: String){
        let url : String = "https://riviera-2017-api.herokuapp.com/api/v1/messages"
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = NSURL(string: url) as URL?
        
        request.httpMethod = "GET"
        request.addValue("\(token)", forHTTPHeaderField: "auth-token")
        request.timeoutInterval = 60
        
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue(), completionHandler:{ (response, data, error) -> Void in
            do {
                messages.removeAll()
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    let dataArray = jsonResult["data"] as! NSArray
                    for message in dataArray{
                        let message = message as! NSDictionary
                        let from = message["from"] as! NSDictionary
                        let sender = from["name"] as! String
                        let username = from["username"] as! String
                        let text = message["text"] as! String
                        let receivedMessage = Message(sender: sender, username: username, text: text)

                        messages.insert(receivedMessage, at: 0)
                    }
                }
                if localMessages.count != messages.count
                {
                    localMessages = messages
                    self.tableView.reloadData()
                }
            }
            
            catch let error as NSError {
                print(error.localizedDescription)
            }
            }
        )//Connection Ends Here
    }//FUNC makeGetRequest Ends Here
    
    func sendMessage(){
        self.makePostRequest(token: tokenStored)
    }
    
    func makePostRequest(token: String){
        
        var request = URLRequest(url: URL(string: "https://riviera-2017-api.herokuapp.com/api/v1/messages")!)
        request.httpMethod = "POST"
        request.addValue("\(token)", forHTTPHeaderField: "auth-token")
        let postString = "message=\(messageSaved)&to=\(recipient)"
        print(postString)
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] {
                    
                    print(jsonResult)
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
        recipient = "all"
        return
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MessagesCell
        cell.senderLabel.text = localMessages[indexPath.section].sender
        cell.usernameLabel.text = localMessages[indexPath.section].username
        cell.messageLabel.text = localMessages[indexPath.section].text
        
        cell.backgroundColor = UIColor(colorLiteralRed: 241, green: 240, blue: 235, alpha: 1)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.7
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true

        return cell
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
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
