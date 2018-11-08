import UIKit
//var blockedNumbers3 = [String]()


class TableViewControllerX: UITableViewController {
    
    var blockedNumbers2 = [String]()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }
    var style:UIStatusBarStyle = .lightContent
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        blockedNumbers2 = defaults.stringArray(forKey: "BlockedNumbersArray") ?? [String]()
        let itemToRemove = "1"
        if let index = blockedNumbers2.index(of: itemToRemove) {
            blockedNumbers2.remove(at: index)
        }

        print(blockedNumbers2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        tableView.reloadData()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blockedNumbers2.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = blockedNumbers2[indexPath.row]        
        return cell
    }
    


}
