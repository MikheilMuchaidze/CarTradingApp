import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

extension MainCarsListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as! CarTableViewCell
        
        cell.carMarkLbl.text = "BMW"
        cell.carModelLbl.text = "Z4"
        cell.carYearLbl.text = "\(2014)"
        cell.carLocationLbl.text = "Tbilisi"
        cell.carPriceLbl.text = "\(12_000)"
        
        return cell
    }
    
    
    
    

    

}

