//
//  Developers.swift
//  Riviera17
//

//

import UIKit
import SWRevealViewController

class Developers: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var hamburgerButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var namesArray = ["Rishabh Chadha", "Harsh Khara", "Abhinav", "Himanshu Jain", "Harshal Varday", "Tushar Narula",  "Waris Chutani", "Saurabh Mathur","Rishabh Mittal", "Karishnu Poddar", "Vishwajeetsinh Jadega", "Akanshi Srivastava", "Mayank Aggarwal", "Vishwash Tilala", "Ankur Sarode", "Aditya Shaha",  "Anish Singh Walia"]
    
    var regNoArray = ["13BCE0034","13BCL0139","13BCE0680","14BCE0531","14BCE0751","14BCE0336","14BIT0155","14BIT0180","15BCB0076","15BCE0318","15BIT0136","15BCE0325","15BCE0751","15BME0007","15BCE0785","15BCE0227","15BIT0116"]
    
    var imagesArray = ["x0","x1","x2","x7","x3","x4","x5","x6","x15","x8","x9","x10","x11","x12","x13","x14",  "x16"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = .blackOpaque

        self.automaticallyAdjustsScrollViewInsets = false
        if self.revealViewController() != nil {
            self.hamburgerButton.target = self.revealViewController()
            self.hamburgerButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 17
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DevelopersCell
        cell.nameLabel.text = namesArray[indexPath.row]
        cell.regNoLabel.text = regNoArray[indexPath.row]
        cell.thumbnail.image = UIImage(named: imagesArray[indexPath.row])
        
        cell.thumbnail.layer.cornerRadius = (cell.thumbnail.layer.frame.width/2)
        cell.thumbnail.layer.masksToBounds = true
        cell.thumbnail.layer.borderColor = UIColor.darkGray.cgColor
        cell.thumbnail.layer.borderWidth = 2
        
        return cell
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
