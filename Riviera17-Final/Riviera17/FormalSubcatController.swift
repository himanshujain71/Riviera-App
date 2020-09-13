//
//  FormalSubcatController.swift
//  Riviera17
//

//

import UIKit

class FormalSubcatController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var imageTop: UIImageView!
    var stringPassed = ""
    var numOfCells = 0
    var listArray = formal
    var subArray = ["Words Worth Telugu", "Quiz Events", "Words Worth Hindi", "Dance Music Events", "Quiz Events", "Words Worth English", "Words Worth Tamil", "Drama", "Cyber Engage"]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor.clear
        self.tableView.layer.backgroundColor = UIColor.black.cgColor
        self.tableView.layer.cornerRadius = 4
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.rowHeight = 70
        
        if stringPassed == "Words Worth Telugu"{
            listArray = WWTU
            imageTop.image = UIImage(named: "formalList")
            self.navigationItem.title = "Words Worth Telugu"
        }
        else if stringPassed == "Quiz Events"{
            listArray = QE
            imageTop.image = UIImage(named: "formalList")
            self.navigationItem.title = "Quiz Events"
        }
        else if stringPassed == "Words Worth Hindi"{
            listArray = WWH
            imageTop.image = UIImage(named: "formalList")
            self.navigationItem.title = "Words Worth Hindi"
        }
        else if stringPassed == "Dance"{
            listArray = Dance
            imageTop.image = UIImage(named: "formalList")
            self.navigationItem.title = "Dance"
        }
        else if stringPassed == "Music Events"{
            listArray = ME
            imageTop.image = UIImage(named: "formalList")
            self.navigationItem.title = "Music Events"
        }
        else if stringPassed == "Words Worth English"{
            listArray = WWE
            imageTop.image = UIImage(named: "formalList")
            self.navigationItem.title = "Words Worth English"
        }
        else if stringPassed == "Words Worth Tamil"{
            listArray = WWT
            imageTop.image = UIImage(named: "formalList")
            self.navigationItem.title = "Words Worth Tamil"
        }
        else if stringPassed == "Drama"{
            listArray = Drama
            imageTop.image = UIImage(named: "formalList")
            self.navigationItem.title = "Drama"
        }
        else if stringPassed == "Cyber Engage"{
            listArray = CE
            imageTop.image = UIImage(named: "formalList")
            self.navigationItem.title = "Cyber Engage"
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listArray.count
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
    
    func gradient(frame:CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0,y: 0.5)
        layer.locations = [0.0, 5.0]
        //        layer.endPoint = CGPoint(x: 1.0,y: 0.5)
        layer.colors = [ UIColor(red: 48/255, green: 35/255, blue: 74/255, alpha: 1).cgColor, UIColor(red: 200/255, green: 109/255, blue: 215/255, alpha: 1).cgColor]
        return layer
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        cell.layer.insertSublayer(gradient(frame: cell.bounds), at:0)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor(red:0, green:0.102, blue: 0.2, alpha: 1)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.7
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
            cell.eventName.text = listArray[indexPath.section].event_name
            cell.chapterName.text = listArray[indexPath.section].event_chapter_name
            cell.eventName.adjustsFontSizeToFitWidth = true

        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let parentController = segue.destination as! UITabBarController
                
                let controller = parentController.viewControllers?[0] as! DetailViewController
                controller.eventIDReceived = listArray[indexPath.section].event_id
                controller.eventNameRecevied = listArray[indexPath.section].event_name
                controller.chapterNameReceived = listArray[indexPath.section].event_chapter_name
                controller.categoryReceived = listArray[indexPath.section].event_category
                controller.descReceived = listArray[indexPath.section].event_desc
                controller.rulesReceived = listArray[indexPath.section].event_rules
                controller.feeReceived = listArray[indexPath.section].fees
                
                let controller2 = parentController.viewControllers?[1] as! CodViewController
                controller2.cod1NameReceived = listArray[indexPath.section].cod1Name
                controller2.cod1RegReceived = listArray[indexPath.section].cod1RegNo
                controller2.cod1PhoneReceived = listArray[indexPath.section].cod1Phone
                controller2.cod1EmailReceived = listArray[indexPath.section].cod1Email
                
                controller2.cod2NameReceived = listArray[indexPath.section].cod2Name
                controller2.cod2RegReceived = listArray[indexPath.section].cod2RegNo
                controller2.cod2PhoneReceived = listArray[indexPath.section].cod2Phone
                controller2.cod2EmailReceived = listArray[indexPath.section].cod2Email
            }
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
