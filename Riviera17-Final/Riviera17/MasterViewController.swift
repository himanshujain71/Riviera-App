//
//  MasterViewController.swift
//  Riviera17
//

//

import UIKit

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var hamburgerButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var items = ["Premium","Pre-Riviera","Workshop","Formal","Informal", "Adventure Sports"]
    var bgs = ["premium.jpeg","pre riviera.jpeg","workshop.jpg","formal.jpg","informals.jpg", "adventure.jpeg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Riviera'17"
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.tableView.rowHeight = 50
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        // Do any additional setup after loading the view.
        
        if self.revealViewController() != nil {
            self.hamburgerButton.target = self.revealViewController()
            self.hamburgerButton.action = Selector("revealToggle:")
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MasterTableViewCell
        cell.cellTitle.text = items[indexPath.row]
        cell.cellBG.image = UIImage(named: bgs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if eventsCollection.count == 0 {
            let alert = UIAlertController(title: "Error", message: "Please Wait while we fetch the events", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else{
        performSegue(withIdentifier: "ShowList", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowList" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                if indexPath.row == 3
                {
                    enteredFormal = true
                    let controller = segue.destination as! ListController
                    controller.stringPassed = items[indexPath.row]
                }
                else{
                let controller = segue.destination as! ListController
                controller.stringPassed = items[indexPath.row]
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        enteredFormal = false
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
