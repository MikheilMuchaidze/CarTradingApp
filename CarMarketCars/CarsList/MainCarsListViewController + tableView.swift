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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as! CarTableViewCell
        cell.testLbl.text = "123"
        
//        cell.backgroundColor = UIColor.white
//        cell.layer.borderColor = UIColor.systemBlue.cgColor
//        cell.layer.borderWidth = 3
//        cell.layer.cornerRadius = 10
//        cell.clipsToBounds = true
        
        return cell
    }
    
    
    
    

    

}

