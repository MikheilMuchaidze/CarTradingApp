import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class newCarUploadViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var carImage: UIImageView!
    
    @IBAction func addCarImageBtn(_ sender: Any) {
        let test = UIImage(systemName: "car")
        carImage.image = test
    }
    
    
    @IBAction func removeCarImageBtn(_ sender: Any) {
        carImage.image = nil
    }
    
    @IBOutlet weak var carMarkTxt: UITextField!
    @IBOutlet weak var carModelTxt: UITextField!
    @IBOutlet weak var carYearTxt: UITextField!
    @IBOutlet weak var carLocationTxt: UITextField!
    @IBOutlet weak var carPriceTxt: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        carImage.layer.cornerRadius = 10
        carImage.layer.borderColor = UIColor.systemBlue.cgColor
        carImage.layer.borderWidth = 2
        carImage.backgroundColor = .clear

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
    
    @IBAction func addCarToListBtn(_ sender: Any) {
        
        if validateIfEmpty() == true && validateIfImageIsEmpty() == true {
            
            
            
            
            dismiss(animated: true)
        }
    }
    
    
    @IBAction func resetTxtFields(_ sender: Any) {
        let allTxtFields = [carMarkTxt, carModelTxt, carYearTxt, carLocationTxt, carPriceTxt]
        allTxtFields.forEach { elem in
            elem?.text?.removeAll()
        }
    }
    


}
