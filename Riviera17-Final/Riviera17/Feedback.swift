

import UIKit
import MessageUI
import SWRevealViewController

class Feedback: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var hamburgerButton: UIBarButtonItem!
    @IBOutlet weak var pickerField: UITextField!
    @IBOutlet weak var review: UITextView!
    
    var pickerView = UIPickerView()
    var options = ["","General Feedback", "Have a Question?", "Report an Issue"]
    var toolbar = UIToolbar()
    var email1 = "himanshujain71@gmail.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        
        if self.revealViewController() != nil {
            self.hamburgerButton.target = self.revealViewController()
            self.hamburgerButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        review.layer.borderColor = UIColor.gray.cgColor
        review.layer.borderWidth = 0.5
        pickerField.allowsEditingTextAttributes = false
        review.layer.cornerRadius = 9
        pickerField.layer.cornerRadius = 9
        
        toolbar.barStyle = UIBarStyle.blackOpaque
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(Feedback.donePicker))
        doneButton.tintColor = UIColor.white
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        pickerField.inputView = pickerView
        pickerField.inputAccessoryView = toolbar
        review.inputAccessoryView = toolbar
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        self.pickerField.delegate = self
        self.review.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    func donePicker(){
        pickerField.resignFirstResponder()
        review.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerField.text = options[row]
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if review.text == "Please Write Here"
        {
            review.text = ""
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.review.endEditing(true)
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: NSError?) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    func showSendMailErrorAlert() {
        //        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        
        let sendMailErrorAlert1 = UIAlertController(title: "Could Not Send Email", message: "Your device could not send the e-mail. Please check Mail Configuration and try again.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        sendMailErrorAlert1.addAction(okButton)
        self.present(sendMailErrorAlert1, animated: true, completion: nil)
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let subject = pickerField.text
        let emailBody = review.text
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["\(email1)"])
        mailComposerVC.setSubject(subject!)
        mailComposerVC.setMessageBody(emailBody!, isHTML: false)
        
        return mailComposerVC
    }
    
    @IBAction func sendEmailButtonTapped(_ sender: AnyObject) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            //self.showSendMailErrorAlert()
        }
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
