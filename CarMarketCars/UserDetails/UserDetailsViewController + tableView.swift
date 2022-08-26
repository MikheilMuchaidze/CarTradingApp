import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

extension UserDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    //enabling swiping funcionality for the row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //action for swiping row
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            self.carsList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }
    
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailsTableViewCell", for: indexPath) as! UserDetailsTableViewCell
        let thisCar = carsList[indexPath.row]
        
        cell.carMarkLbl.text = thisCar["Mark"] as? String
        cell.carModelLbl.text = thisCar["Model"] as? String
        cell.carYearLbl.text = thisCar["Year"] as? String
        cell.carLocationLbl.text = thisCar["Location"] as? String
        cell.carPriceLbl.text = thisCar["Price"] as? String
        
        return cell
    }
    
    
    
    
    
}
