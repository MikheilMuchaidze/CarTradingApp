import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class NewCarUploadViewController: UIViewController {
    
    //MARK: - Clean Components
    
    
    //MARK: - Fields

    var handle: AuthStateDidChangeListenerHandle?
    var carUploadPageStatus: carUploadStatus!
    var editingCar: Car!
    var sellable: Bool = true
    let uuid = UUID().uuidString
    
    //MARK: - Outlets
    
    @IBOutlet weak var addCarToListBtnOutlet: UIButton!
    @IBOutlet weak var titleTextLbl: UILabel!
    @IBOutlet weak var updateCarToListBtnOutlet: UIButton!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet var addLinkView: UIView!
    @IBOutlet weak var insertedLinkTxt: UITextField!
    @IBOutlet weak var carMarkTxt: UITextField!
    @IBOutlet weak var carModelTxt: UITextField!
    @IBOutlet weak var carYearTxt: UITextField!
    @IBOutlet weak var carLocationTxt: UITextField!
    @IBOutlet weak var carPriceTxt: UITextField!
    @IBOutlet weak var carPhoneTxt: UITextField!
    @IBOutlet weak var sellableStatusOutlet: UISwitch!
    @IBOutlet weak var addCarImageWithUrl: UIButton!
    @IBOutlet weak var addCarImageFromGallery: UIButton!
    @IBOutlet weak var removeCarImage: UIButton!
    @IBOutlet weak var sellNowText: UILabel!
    @IBOutlet weak var resetTxtFieldsOutlet: UIButton!
    
    //MARK: - Object Lifecycle
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cleanAllFields()
    }
    
    //MARK: - Setup
    
    private func setup() {
        carImage.layer.cornerRadius = 10
        carImage.layer.borderColor = UIColor.systemBlue.cgColor
        carImage.layer.borderWidth = 2
        carImage.backgroundColor = .clear
        //set width = 300, height = 140
        addLinkView.bounds = CGRect(x: 0, y: 0, width: 300, height: 140)
        //editing mode choose
        carUpload(page: carUploadPageStatus)
    }
    
    //MARK: - Methods
    
    private func cleanAllFields() {
        let allTxtFields = [carMarkTxt, carModelTxt, carYearTxt, carLocationTxt, carPriceTxt, carPhoneTxt]
        allTxtFields.forEach { elem in
            elem?.text?.removeAll()
        }
    }
    
    //MARK: - Actions
    
    @IBAction func addCarImageWithUrlBtn(_ sender: Any) {
        animateIn(desiredView: addLinkView)
    }
    
    @IBAction func addCarImageFromGalleryBtn(_ sender: Any) {
        showImagePickerController()
        loader(isLoading: false)
    }
    
    @IBAction func linkLoadToImageBtn(_ sender: Any) {
        
        guard let imageUrl = insertedLinkTxt.text else { return }
        
        if imageUrl == "" {
            alertPopUp(title: NewCarValidationTitles.imageUrlError, message: NewCarValidationMessages.imageUrlErrorMassage, okTitle: NewCarValidationOkTitles.okTitle)
            carImage.image = nil
        } else {
            guard let url = URL(string: imageUrl) else { return }
            carImage.loadImageFrom(url: url)
            insertedLinkTxt.text = nil
            animateOut(desiredView: addLinkView)
        }
        
    }
    
    @IBAction func addLinkViewExit(_ sender: Any) {
        insertedLinkTxt.text = nil
        animateOut(desiredView: addLinkView)
    }
    
    @IBAction func removeCarImageBtn(_ sender: Any) {
        carImage.image = nil
        loader(isLoading: true)
    }
    
    @IBAction func sellableStatusAction(_ sender: UISwitch) {
        sellable = sender.isOn
    }

    @IBAction func addCarToListBtn(_ sender: Any) {
        
        if validateIfEmpty() && validateIfImageIsEmpty()  {
            handle = Auth.auth().addStateDidChangeListener({ auth, user in
                guard let currentUser = user else { return }
                let carsDb = Firestore.firestore().collection(FirebaseCollectionNames.cars.rawValue)
                carsDb.document(self.uuid).setData([
                    "DocumentID": self.uuid,
                    "Email": "\(currentUser.email ?? "")",
                    "Mark": self.carMarkTxt.text!,
                    "Model": self.carModelTxt.text!,
                    "Year": self.carYearTxt.text!,
                    "Location": self.carLocationTxt.text!,
                    "Price": self.carPriceTxt.text!,
                    "Phone": self.carPhoneTxt.text!,
                    "Sellable": self.sellable
                ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("Document added")
                        self.dismiss(animated: true)
                    }
                }
                if let imageData = self.carImage.image?.jpegData(compressionQuality: 0.5) {
                    FirebaseService.imageUploader(image: imageData, uid: self.uuid) { metadata, error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }
            })
        }
    
        
    }
    
    @IBAction func resetTxtFields(_ sender: Any) {
        cleanAllFields()
    }
    
    @IBAction func updateCarToListBtn(_ sender: Any) {
        
        if validateIfEmpty() && validateIfImageIsEmpty()  {
            let carsDb = Firestore.firestore().collection(FirebaseCollectionNames.cars.rawValue)
            carsDb.document(editingCar.documentID).updateData([
                "Mark": self.carMarkTxt.text!,
                "Model": self.carModelTxt.text!,
                "Year": self.carYearTxt.text!,
                "Location": self.carLocationTxt.text!,
                "Price": self.carPriceTxt.text!,
                "Phone": self.carPhoneTxt.text!,
                "Sellable": self.sellable
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Document updated")
                    self.dismiss(animated: true)
                }
            }
            if let imageData = self.carImage.image?.jpegData(compressionQuality: 0.5) {
                FirebaseService.imageUploader(image: imageData, uid: editingCar.documentID) { metadata, error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            
        }
    }
    
}




