//
//  AllEventsList.swift
//  Riviera17

//

import UIKit

class AllEventsList: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!
    
    
    var filteredEvents = [EventDetails]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        self.tableView.reloadData()
        self.automaticallyAdjustsScrollViewInsets = false;

        // Do any additional setup after loading the view.
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredEvents = eventsCollection.filter { event in
            return event.event_name.lowercased().contains(searchText.lowercased())
        }
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredEvents.count
        }
        return eventsCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        let event: EventDetails
        if searchController.isActive && searchController.searchBar.text != "" {
            event = filteredEvents[indexPath.row]
        }
        else {
            event = eventsCollection[indexPath.row]
        }
        cell.textLabel?.text = event.event_name
        return cell
    }
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive && searchController.searchBar.text != "" {
            recipient = filteredEvents[indexPath.row].event_id
        }
        else {
            recipient = eventsCollection[indexPath.row].event_id
        }
        MessageBoard().sendMessage()
        let alertSent = UIAlertController(title: "Success", message: "Sent to Event", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertSent.addAction(defaultAction)
        self.present(alertSent, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
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
