import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

extension UserDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    //enabling swiping funcionality for the row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //func for deleting car from table and also from database
    private func delete(rowIndexPathar indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Remove") { [weak self] (_, _, _) in
            guard let self = self else { return }
            
            let thisCar = self.carsList[indexPath.row]
            let currentID = thisCar["DocumentID"] as? String
            
            self.carsdb.document(currentID!).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.carsList.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    self.tableView.reloadData()
                    print("deleted")
                }
            }
            
        }
        
        return action
    }
    
    //func for editing car information
    private func edit(rowIndexPathar indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Edit") { [weak self] (_, _, _) in
            guard let self = self else { return }
            self.alertPopUp(title: "Edit?", message: "You sure want to edit?", okTitle: "Yes!")
        }
        
        return action
    }

    //action for swiping row from right to left (trailing)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = self.edit(rowIndexPathar: indexPath)
        edit.backgroundColor = .green
        let delete = self.delete(rowIndexPathar: indexPath)
        delete.backgroundColor = .red
        let swipers = UISwipeActionsConfiguration(actions: [edit, delete])
        return swipers
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
