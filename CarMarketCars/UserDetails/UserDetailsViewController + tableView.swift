import UIKit

extension UserDetailsViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //enabling swiping funcionality for the row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //func for deleting car from table and also from database
    private func delete(rowIndexPathar indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Remove") { [weak self] (_, _, _) in
            guard let thisCar = self?.carsList[indexPath.row] else { return }
            let currentID = thisCar.documentID
            self?.carsList.remove(at: indexPath.row)
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            self?.tableView.reloadData()
            FirebaseDatabaseEdit.carRemoverFromDb(car: currentID) { error in
                if let error = error {
                    self?.alertPopUp(title: AuthValidationAndAlert.ValidationTitles.carRemoveFromDatabaseFail, message: "\(error.localizedDescription)", okTitle: AuthValidationAndAlert.ValidationOkTitles.ok)
                } else {
                    self?.alertPopUpWithModel(errorPopUpModel: PredefinedAlerMessages.carRemoveFromDbSucces)
                }
            }
            FirebaseDatabaseEdit.imageRemoverFromDb(image: currentID) { error in
                if let error = error {
                    self?.alertPopUp(title: AuthValidationAndAlert.ValidationTitles.imageRemoveFromDatabaseFail, message: "\(error.localizedDescription)", okTitle: AuthValidationAndAlert.ValidationOkTitles.ok)
                }
            }
        }
        return action
    }
    
    //func for editing car information
    private func edit(rowIndexPathar indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Edit") { [weak self] (_, _, _) in
            guard let self = self else { return }
            let storyboard = UIStoryboard(name: StoryboardNames.newCar, bundle: nil)
            guard let toEditPage = storyboard.instantiateViewController(withIdentifier: ViewControllerName.newCar) as? NewCarUploadViewController else { return }
            let thisCar = self.carsList[indexPath.row]
            toEditPage.editingCar = thisCar
            toEditPage.carUploadPageStatus = .UpdatingCar
            self.present(toEditPage, animated: true)
        }
        return action
    }
    
    //action for Delete swiping row from right to left (trailing)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = self.delete(rowIndexPathar: indexPath)
        delete.backgroundColor = .red
        let swiper = UISwipeActionsConfiguration(actions: [delete])
        return swiper
    }
    
    //action for Edit swiping row from left to right (leading)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = self.edit(rowIndexPathar: indexPath)
        edit.backgroundColor = .green
        let swiper = UISwipeActionsConfiguration(actions: [edit])
        return swiper
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
        searchingCarsList.isEmpty ? carsList.count : searchingCarsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellName.UserDetailsTableViewCell, for: indexPath) as? UserDetailsTableViewCell else { return UITableViewCell() }
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
    
    //updating tableview after editing cell
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        self.tableView.reloadData()
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
