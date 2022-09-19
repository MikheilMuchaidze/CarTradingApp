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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellName.CarTableViewCell, for: indexPath) as? CarTableViewCell else { return UITableViewCell() }
        cell.loader(isLoading: true)
        let thisCar = searchingCarsList.isEmpty ? carsList[indexPath.row] : searchingCarsList[indexPath.row]
        FirebaseDatabaseDownload.loadImage(image: thisCar.documentID) { url, error in
            if let error = error {
                self.alertPopUp(title: AuthValidationAndAlert.ValidationTitles.fetchingImageError, message: "\(error.localizedDescription)", okTitle: AuthValidationAndAlert.ValidationOkTitles.ok)
                cell.carImage.image = UIImage(systemName: "eyes.inverse")
            } else {
                guard let url = url else { return }
                cell.carImage.loadImageFrom(url: url)
                cell.loader(isLoading: false)
            }
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
        guard let toCarInfo = storyboard.instantiateViewController(withIdentifier: ViewControllerName.newCar) as? NewCarUploadViewController else { return }
        let thisCar = self.carsList[indexPath.row]
        toCarInfo.editingCar = thisCar
        toCarInfo.carUploadPageStatus = .CarInfo
        self.present(toCarInfo, animated: true)
    }
    
    //searchbar functions
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingCarsList.removeAll()
        guard let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField else { return }
        textFieldInsideSearchBar.textColor = .systemBlue
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



