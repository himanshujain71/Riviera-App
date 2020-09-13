//
//  LoginPage.swift
//  Riviera17
//

//

import UIKit

class LoginPage: UIViewController {

    @IBOutlet weak var logOut: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var hamburgerButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = .blackTranslucent

        if loginValue == true{
            self.passwordField.alpha = 0
            self.userNameField.alpha = 0
            self.loginButtonOutlet.alpha = 0
            self.statusLabel.text = "Logged in as \(loggedInUser)"
            self.logOut.alpha = 1
            self.statusLabel.alpha = 1
        }
        
        else if loginValue == false{
            self.passwordField.alpha = 1
            self.userNameField.alpha = 1
            self.loginButtonOutlet.alpha = 1
            self.statusLabel.text = ""
            self.logOut.alpha = 0
            self.statusLabel.alpha = 0
        }
        
        if self.revealViewController() != nil {
            self.hamburgerButton.target = self.revealViewController()
            self.hamburgerButton.action = Selector("revealToggle:")
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func loginAction(_ sender: AnyObject) {
        
        var request = URLRequest(url: URL(string: "https://riviera-2017-api.herokuapp.com/api/v1/login")!)
        request.httpMethod = "POST"
        let postString = "username=\(userNameField.text!)&password=\(passwordField.text!)"
        print(postString)
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                DispatchQueue.main.async {
        
                let alert = UIAlertController(title: "Error", message: "Weak Internet Connection.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] {
                    
                    let token = jsonResult["token"] as? String ?? "nil"
                    tokenStored = token
                    if tokenStored != "nil"{
                        loginValue = true
                        loggedInUser = self.userNameField.text!
                        self.userNameField.alpha = 0
                        self.passwordField.alpha = 0
                        let alertView1 = UIAlertController(title: "Success", message: "Logged in as \(loggedInUser)", preferredStyle: .alert)
                        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertView1.addAction(dismissAction)
                        DispatchQueue.main.async {
                            self.present(alertView1, animated: true, completion: nil)
                            self.performSegue(withIdentifier: "loginSuccess", sender: self)
                        }
                        self.loginButtonOutlet.alpha = 0.0
                    }
                    else if tokenStored == "nil"{
                        let alertView = UIAlertController(title: "Error", message: "Invalid Credentials or no internet connection", preferredStyle: .alert)
                        let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertView.addAction(dismissAction)
                        DispatchQueue.main.async {
                            self.present(alertView, animated: true, completion: nil)
                        }
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    

    @IBAction func logOutAction(_ sender: Any) {
        exit(0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.passwordField.resignFirstResponder()
        self.userNameField.resignFirstResponder()
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
