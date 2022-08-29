import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class NewCarUploadViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?

    var carUploadPageStatus: carUploadStatus!
    var editingCar: Car!
    var sellable: Bool = true
    let uuid = UUID().uuidString
    
    @IBOutlet weak var addCarToListBtnOutlet: UIButton!
    @IBOutlet weak var titleTextLbl: UILabel!
    @IBOutlet weak var updateCarToListBtnOutlet: UIButton!
    
    @IBOutlet weak var carImage: UIImageView!
    
    @IBOutlet var addLinkView: UIView!
    @IBOutlet weak var insertedLinkTxt: UITextField!
    
    @IBOutlet weak var carMarkTxt: UITextField!
    @IBOutlet weak var carModelTxt: UITextField!
    @IBOutlet weak var carYearTxt: UITextField!
    @IBOutlet weak var carLocationTxt: UITextField!
    @IBOutlet weak var carPriceTxt: UITextField!
    
    @IBOutlet weak var sellableStatusOutlet: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carImage.layer.cornerRadius = 10
        carImage.layer.borderColor = UIColor.systemBlue.cgColor
        carImage.layer.borderWidth = 2
        carImage.backgroundColor = .clear
        
        //set width = 300, height = 140
        addLinkView.bounds = CGRect(x: 0, y: 0, width: 300, height: 140)
        
        //editing mode choose
        carUpload(page: carUploadPageStatus)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            if user == nil {
                print("no user please register")
            } else {
                print("addStateDidChangeListener - newCarUploadViewController")
            }
        })
     
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        carMarkTxt.text = nil
        carModelTxt.text = nil
        carYearTxt.text = nil
        carLocationTxt.text = nil
        carPriceTxt.text = nil
        
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
        print("removeStateDidChangeListener - newCarUploadViewController")
        
    }
    
    
    @IBAction func addCarImageWithUrlBtn(_ sender: Any) {
        animateIn(desiredView: addLinkView)
    }
    
    @IBAction func addCarImageFromGalleryBtn(_ sender: Any) {
        showImagePickerController()
    }
    
    @IBAction func linkLoadToImageBtn(_ sender: Any) {
        
        let imageUrl = insertedLinkTxt.text
        
        if imageUrl == nil || imageUrl == "" {
            alertPopUp(title: "Url Error", message: "Incorrect or empty url in field, please input correct link", okTitle: "Ok.")
            carImage.image = nil
        } else {
            let URL = URL(string: imageUrl!)
            carImage.loadImageFrom(url: URL!)
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
                    self.uploadImage(data: imageData, uuid: self.uuid)
                }
            })
        }
        
    }
    
    @IBAction func resetTxtFields(_ sender: Any) {
        let allTxtFields = [carMarkTxt, carModelTxt, carYearTxt, carLocationTxt, carPriceTxt]
        allTxtFields.forEach { elem in
            elem?.text?.removeAll()
        }
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
                self.uploadImage(data: imageData, uuid: editingCar.documentID)
            }
        }
    }
    
    
}




