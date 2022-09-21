import UIKit

extension UIViewController {
    
    //MARK: - Auth validation functions
    
    //validation of text fields
    func validateIfEmpty(for textFields: [UITextField?], errorPopUpModel: AuthValidationAndAlert.AlertPopupModel) -> Bool {
        for textField in textFields {
            if textField?.text?.isEmpty == true {
                alertPopUp(title: errorPopUpModel.title, message: errorPopUpModel.message, okTitle: errorPopUpModel.okTitle)
                return false
            }
        }
        return true
    }
    
    //validate email form
    func validateEmailForm(for emailString: String?, errorPopUpModel: AuthValidationAndAlert.AlertPopupModel) -> Bool {
        guard let emailValue = emailString else { return false }
        let emailRegEx = AuthValidationAndAlert.AuthEmailPredicate.emailRegEx
        if (!NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: emailValue)) {
            alertPopUp(title: errorPopUpModel.title, message: errorPopUpModel.message, okTitle: errorPopUpModel.okTitle)
            return false
        } else {
            return true
        }
    }
    
    //password validation
    func validatePassword(for passwordString: String?) -> Bool {
        guard let passwordString = passwordString else { return false }
        let passwordUppercase = AuthValidationAndAlert.AuthPasswordPredicate.passwordUppercase
        let passwordDigit = AuthValidationAndAlert.AuthPasswordPredicate.passwordDigit
        let passwordLowercase = AuthValidationAndAlert.AuthPasswordPredicate.passwordLowercase
        let passwordLength = AuthValidationAndAlert.AuthPasswordPredicate.passwordLength
        if (!NSPredicate(format:"SELF MATCHES %@", passwordUppercase).evaluate(with: passwordString)) {
            alertPopUpWithModel(errorPopUpModel: PredefinedAlerMessages.incorrectPasswordOneUppercase)
            return false
        }
        
        if (!NSPredicate(format:"SELF MATCHES %@", passwordDigit).evaluate(with: passwordString)) {
            alertPopUpWithModel(errorPopUpModel: PredefinedAlerMessages.incorrectPasswordOneDigit)
            return false
        }
        
        if (!NSPredicate(format:"SELF MATCHES %@", passwordLowercase).evaluate(with: passwordString)) {
            alertPopUpWithModel(errorPopUpModel: PredefinedAlerMessages.incorrectPasswordOneLowercase)
            return false
        }
        
        if (passwordString.count < passwordLength) {
            alertPopUpWithModel(errorPopUpModel: PredefinedAlerMessages.incorrectPasswordLength)
            return false
        }
        return true
    }
    
    //validate password and repeat password similarity
    func validatePasswordMatch(for textFields: [UITextField?], errorPopUpModel: AuthValidationAndAlert.AlertPopupModel) -> Bool {
        guard let firstField = textFields.first else { return false }
        guard let secondField = textFields.last else { return false }
        if firstField?.text != secondField?.text {
            alertPopUp(title: errorPopUpModel.title, message: errorPopUpModel.message, okTitle: errorPopUpModel.okTitle)
            return false
        } else {
            return true
        }
    }
    
    //validate image form
    func ifImageIsEmpty(for imageSoruce: UIImageView?) -> Bool {
        guard let imageSoruce = imageSoruce else { return false }
        if imageSoruce.image == nil {
            alertPopUpWithModel(errorPopUpModel: PredefinedAlerMessages.noImageError)
            return false
        } else {
            return true
        }
    }
    
    //MARK: - Popup view animations
    
    //animate in a specific view
    func animateIn(desiredView: UIView) {
        let backgroundView = self.view!
        //attach our desired view to the screen (self.view/backgroundView)
        backgroundView.addSubview(desiredView)
        //sets the view's scaling to be 120%
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = backgroundView.center
        //animate the affect
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
        })
    }
    
    //animate out a specified view
    func animateOut(desiredView: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 0
        }, completion: { _ in
            desiredView.removeFromSuperview()
        })
    }
    
    //MARK: - Tap fucntionality for sign out and profile pics
    
    //funcion for add back option to image
    func addTapToGoBackToImage(image: UIImageView) {
        image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToGoBack))
        image.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapToGoBack() {
        FirebaseAuth.logOutUser { error in
            alertPopUp(title: AuthValidationAndAlert.ValidationTitles.loggedOutFail, message: error.localizedDescription, okTitle: AuthValidationAndAlert.ValidationOkTitles.ok)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    //funcion for presenting view to image
    func addTapToGoToDetailsToImage(image: UIImageView) {
        image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToGoToDetails))
        image.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapToGoToDetails() {
        let toDetailsVC = UIStoryboard(name: StoryboardNames.userDetails, bundle: nil)
        guard let toDetailsVC = toDetailsVC.instantiateViewController(withIdentifier: ViewControllerName.userDetails) as? UserDetailsViewController else { return }
        self.present(toDetailsVC, animated: true)
    }
    
    //function for touching outside of the UITextField and then keyboard will hide
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action:    #selector(UIViewController.dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
    
    //MARK: - Alert massege funcion
    
    //general popup message without AlerModel struct
    func alertPopUp(title: String, message: String, okTitle: String) {
        let alertmassege = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: okTitle, style: UIAlertAction.Style.default, handler: nil)
        alertmassege.addAction(okAction)
        self.present(alertmassege, animated: true)
    }
    
    //alert popup model with AlertModel Struct
    func alertPopUpWithModel(errorPopUpModel: AuthValidationAndAlert.AlertPopupModel) {
        alertPopUp(title: errorPopUpModel.title, message: errorPopUpModel.message, okTitle: errorPopUpModel.okTitle)
    }
    
}

//MARK: - New car upload/show/edit page extension

extension NewCarUploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Image picker
    
    //function that shows image picker
    func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            carImage.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            carImage.image = originalImage
        }
        dismiss(animated: true)
    }
    
    //MARK: - enums for choosing newcar view: enums for upload, update and view
    
    //enums for additing and editing a car
    enum carUploadStatus {
        case AddingCar
        case UpdatingCar
        case CarInfo
    }
    
    //add aditing mode for view controler: adding new car and updating existing one
    func carUpload(page status: carUploadStatus) {
        switch status {
        case .AddingCar:
            addNewCar()
        case .UpdatingCar:
            updateCar()
        case .CarInfo:
            carInfo()
        }
    }
    
    private func addNewCar() {
        loader(isLoading: true)
        addCarToListBtnOutlet.isHidden = false
        titleTextLbl.isHidden = false
        updateCarToListBtnOutlet.isHidden = true
        loader(isLoading: true)
    }
    
    private func carInfo() {
        loader(isLoading: true)
        let outletsList = [addCarToListBtnOutlet, titleTextLbl, updateCarToListBtnOutlet, sellableStatusOutlet, addCarImageWithUrl, addCarImageFromGallery, removeCarImage, sellNowText, resetTxtFieldsOutlet]
        outletsList.forEach { elem in
            elem?.isHidden = true
        }
        initEditingCar()
        let fieldsList = [carMarkTxt, carModelTxt, carYearTxt, carLocationTxt, carPriceTxt, carPhoneTxt, sellableStatusOutlet]
        fieldsList.forEach { elem in
            elem?.isEnabled = false
        }
        fetchImageByUserId()
    }
    
    private func updateCar() {
        addCarToListBtnOutlet.isHidden = true
        titleTextLbl.isHidden = true
        updateCarToListBtnOutlet.isHidden = false
        initEditingCar()
        fetchImageByUserId()
    }
    
    //get editing car from carsls list
    private func initEditingCar() {
        guard let editingCar = editingCar else { return }
        carMarkTxt.text = editingCar.mark
        carModelTxt.text = editingCar.model
        carYearTxt.text = editingCar.year
        carLocationTxt.text = editingCar.location
        carPriceTxt.text = editingCar.price
        carPhoneTxt.text = editingCar.phone
        sellableStatusOutlet.isOn = editingCar.sellable
    }
    
    //fetch images from storage by user documendID
    private func fetchImageByUserId() {
        FirebaseDatabaseDownload.loadImage(image: editingCar?.documentID ?? "") { [weak self] url, error in
            if let error = error {
                self?.alertPopUp(title: AuthValidationAndAlert.ValidationTitles.fetchingImageError, message: "\(error.localizedDescription)", okTitle: AuthValidationAndAlert.ValidationOkTitles.ok)
                self?.carImage.image = UIImage(systemName: "eyes.inverse")
            } else {
                guard let url = url else { return }
                self?.carImage.loadImageFrom(url: url)
                self?.loader(isLoading: false)
            }
        }
    }
    
}

//MARK: - Main table view refresh if pulled from top

extension MainCarsListViewController {
    
    //function to reload table when its pulled from top
    func tablePullToRefresh() {
        //for refreshin when scrolled up
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl?.tintColor = .systemIndigo
    }
    
    //refreshing objc funtion itself
    @objc func didPullToRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.fetchCars()
        }
    }
    
    //fetching car data from database
    private func fetchCars() {
        FirebaseDatabaseDownload.fetchCars { [weak self] snapshot, error in
            guard let snapshot = snapshot?.documents else { return }
            self?.carsList.removeAll()
            snapshot.forEach { elem in
                self?.carsList.append(Car(with: elem.data()))
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
    }
    
}

