import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import UIKit


extension UIViewController {
    
    //MARK: Tap fucntionality for sign out and profile pics
    
    //funcion for add back option to image
    func addTapToGoBackToImage(image: UIImageView) {
        image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToGoBack))
        image.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapToGoBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //funcion for presenting view to image
    func addTapToGoToDetailsToImage(image: UIImageView) {
        image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToGoToDetails))
        image.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapToGoToDetails() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "UserDetailsViewController")
        guard let vc = vc else { return }
        self.present(vc, animated: true)
    }
}

//MARK: Alert massege funcion

extension UIViewController {
    
    func alertPopUp(title: String, message: String, okTitle: String) {
        let alertmassege = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: okTitle, style: UIAlertAction.Style.default, handler: nil)
        alertmassege.addAction(okAction)
        self.present(alertmassege, animated: true)
    }
    
}

//MARK: Popup view animations

extension UIViewController {
    
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
    
    //MARK: Upload image to firebase

    func uploadImage(data: Data, uuid:  String) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let localFile = data
        let photoRef = storageRef.child("carImages/\(uuid)")
        photoRef.putData(localFile) { metadata, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}

//MARK: Imageview load image from url

extension UIImageView {
    
    //load image from url
    func loadImageFrom(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}

//MARK: adding new car view: image picker from galley functions

extension NewCarUploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //function that shows image picker
    func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
//        imagePickerController.sourceType = chooseAction
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
    
    //MARK: enums for choosing newcar view: enums for upload, update and view
    
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
    
    func carInfo() {
        indicator.isHidden = false
        indicator.startAnimating()
        
        let outletsList = [addCarToListBtnOutlet, titleTextLbl, updateCarToListBtnOutlet, sellableStatusOutlet, addCarImageWithUrl, addCarImageFromGallery, removeCarImage, sellNowText, resetTxtFieldsOutlet]
        outletsList.forEach { elem in
            elem?.isHidden = true
        }
        
        carMarkTxt.text = editingCar.mark
        carModelTxt.text = editingCar.model
        carYearTxt.text = editingCar.year
        carLocationTxt.text = editingCar.location
        carPriceTxt.text = editingCar.price
        carPhoneTxt.text = editingCar.phone
        sellableStatusOutlet.isOn = editingCar.sellable
        
        let fieldsList = [carMarkTxt, carModelTxt, carYearTxt, carLocationTxt, carPriceTxt, carPhoneTxt, sellableStatusOutlet]
        
        fieldsList.forEach { elem in
            elem?.isEnabled = false
        }
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let photoRef = storageRef.child("carImages/\(editingCar.documentID)")
        photoRef.downloadURL { url, error in
            guard let url = url else { return }
            self.carImage.loadImageFrom(url: url)
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }
    }
    
    func addNewCar() {
        indicator.isHidden = false
        indicator.startAnimating()
        
        addCarToListBtnOutlet.isHidden = false
        titleTextLbl.isHidden = false
        updateCarToListBtnOutlet.isHidden = true
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    func updateCar() {
        addCarToListBtnOutlet.isHidden = true
        titleTextLbl.isHidden = true
        updateCarToListBtnOutlet.isHidden = false
        
        carMarkTxt.text = editingCar.mark
        carModelTxt.text = editingCar.model
        carYearTxt.text = editingCar.year
        carLocationTxt.text = editingCar.location
        carPriceTxt.text = editingCar.price
        carPhoneTxt.text = editingCar.phone
        sellableStatusOutlet.isOn = editingCar.sellable
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let photoRef = storageRef.child("carImages/\(editingCar.documentID)")
        photoRef.downloadURL { url, error in
            guard let url = url else { return }
            self.carImage.loadImageFrom(url: url)
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }
    }
     
}

//MARK: main table view refresh if pulled from top

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
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
}


