import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

extension MainCarsListViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
        
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
        searchingCarsList.isEmpty ? carsList.count : searchingCarsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as! CarTableViewCell
        let thisCar = searchingCarsList.isEmpty ? carsList[indexPath.row] : searchingCarsList[indexPath.row]
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let photoRef = storageRef.child("carImages/\(thisCar.documentID)")
        photoRef.downloadURL { url, error in
            guard let url = url else { return }
            cell.carImage.loadImageFrom(url: url)
        }
        
        cell.carMarkLbl.text = thisCar.mark
        cell.carModelLbl.text = thisCar.model
        cell.carYearLbl.text = thisCar.year
        cell.carLocationLbl.text = thisCar.location
        cell.carPriceLbl.text = thisCar.price
        
        return cell
    }
    
    //searchbar functions
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingCarsList.removeAll()
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .systemBlue
        
        if searchText == "" {
            searchingCarsList = carsList
        } else {
            for item in carsList {
                if item.model.lowercased().contains(searchText.lowercased()) {
                    searchingCarsList.append(item)
                }
            }
        }
        self.tableView.reloadData()
    }

}



