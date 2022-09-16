import UIKit

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
        let cell = tableView.dequeueReusableCell(withIdentifier: CellName.CarTableViewCell, for: indexPath) as! CarTableViewCell
//        cell.loader(isLoading: true)
        let thisCar = searchingCarsList.isEmpty ? carsList[indexPath.row] : searchingCarsList[indexPath.row]
        
        FirebaseDatabaseDownload.loadImage(image: thisCar.documentID) { url, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let url = url else { return }
            cell.carImage.loadImageFrom(url: url)
//            cell.loader(isLoading: false)
        }
        
        cell.carMarkLbl.text = thisCar.mark
        cell.carModelLbl.text = thisCar.model
        cell.carYearLbl.text = thisCar.year
        cell.carLocationLbl.text = thisCar.location
        cell.carPriceLbl.text = thisCar.price
        cell.carPhoneLbl.text = thisCar.phone
        
        return cell
    }
    
    //function to get to car info page when clicking
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: StoryboardNames.newCar, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerName.newCar) as? NewCarUploadViewController else { return }
        let thisCar = self.carsList[indexPath.row]
        vc.editingCar = thisCar
        vc.carUploadPageStatus = .CarInfo
        self.present(vc, animated: true)
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



