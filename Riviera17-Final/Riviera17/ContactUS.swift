//
//  ContactUS.swift
//  Riviera17
//

//

import UIKit
import SWRevealViewController

class ContactUS: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var contacts: [String] = ["Rishabh Chadha","Harsh Khara"]
    var phones: [String] = ["+919629766583", "+919920555055"]
    var images = ["x0","x1"]
    
    @IBOutlet weak var hamburgerButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            self.hamburgerButton.target = self.revealViewController()
            self.hamburgerButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.automaticallyAdjustsScrollViewInsets = false;
        self.tableView.isScrollEnabled = false
        self.tableView.tableFooterView = UIView()
        self.tableView.tableFooterView?.isHidden = true
        self.tableView.allowsSelection = false
        self.tableView.layer.backgroundColor = UIColor.clear.cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contacts.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactUsCell
        cell.NameLabel.text = contacts[indexPath.section]
        cell.PhoneLabel.text = phones[indexPath.section]
        cell.thumbnail.image = UIImage(named: images[indexPath.section])
        cell.thumbnail.layer.cornerRadius = cell.thumbnail.frame.width/2
        cell.thumbnail.clipsToBounds = true
        
        cell.layer.backgroundColor = UIColor(red: 0.0275/255, green: 0.1098/255, blue: 0.2118/255, alpha: 0.5).cgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let callAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Phone",handler: { (action, indexPath) -> Void in
            UIApplication.shared.openURL(URL(string:"tel://"+"\(self.phones[(indexPath).section])")!)
        })
        callAction.backgroundColor = UIColor(red: 59.0/255.0, green: 215.0/255.0, blue: 83.0/255.0, alpha: 0.5)
        return [callAction]
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
