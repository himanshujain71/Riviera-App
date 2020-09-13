//
//  CodViewController.swift
//  Riviera17
//

//

import UIKit

class CodViewController: UIViewController {

    @IBOutlet weak var cod2EmailLabel: UILabel!
    @IBOutlet weak var cod2PhoneLabel: UILabel!
    @IBOutlet weak var cod2RegLabel: UILabel!
    @IBOutlet weak var cod2NameLabel: UILabel!
    @IBOutlet weak var cod1EmailLabel: UILabel!
    @IBOutlet weak var cod1PhoneLabel: UILabel!
    @IBOutlet weak var cod1RegLabel: UILabel!
    @IBOutlet weak var cod1NameLabel: UILabel!
    
    var cod1NameReceived = ""
    var cod1RegReceived = ""
    var cod1PhoneReceived = ""
    var cod1EmailReceived = ""
    
    var cod2NameReceived = ""
    var cod2RegReceived = ""
    var cod2PhoneReceived = ""
    var cod2EmailReceived = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cod1NameLabel.text = cod1NameReceived
        cod1RegLabel.text = cod1RegReceived
        cod1PhoneLabel.text = cod1PhoneReceived
        cod1EmailLabel.text = cod1EmailReceived
        
        cod2NameLabel.text = cod2NameReceived
        cod2RegLabel.text = cod2RegReceived
        cod2PhoneLabel.text = cod2PhoneReceived
        cod2EmailLabel.text = cod2EmailReceived
        // Do any additional setup after loading the view.
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
