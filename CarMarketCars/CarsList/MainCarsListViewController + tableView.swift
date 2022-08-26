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
        return carsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as! CarTableViewCell
        let thisCar = carsList[indexPath.row]
        
        cell.carMarkLbl.text = thisCar["Mark"] as? String
        cell.carModelLbl.text = thisCar["Model"] as? String
        cell.carYearLbl.text = thisCar["Year"] as? String
        cell.carLocationLbl.text = thisCar["Location"] as? String
        cell.carPriceLbl.text = thisCar["Price"] as? String
        
        return cell
    }
    
    
    
    

    

}

