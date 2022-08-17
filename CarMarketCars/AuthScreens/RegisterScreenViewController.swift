import UIKit
import Firebase
import FirebaseAuth

class RegisterScreenViewController: UIViewController {
    
    @IBOutlet weak var UserEmailTxt: UITextField!
    @IBOutlet weak var UserPasswordTxt: UITextField!
    @IBOutlet weak var UserRepeatPassTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //clear all fields
    @IBAction func resetAllFields(_ sender: Any) {
        let allTxtFields = [UserEmailTxt, UserPasswordTxt, UserRepeatPassTxt]
        allTxtFields.forEach { elem in
            elem?.text?.removeAll()
        }
        
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        
        if validateIfEmpty() == true &&
            validateIfPasswordMatch() == true &&
            validateIfPassword(str: UserPasswordTxt.text!) == true &&
            validateIfEmailCorrectForm(str: UserEmailTxt.text!) {
            
            print("wohoo from sign up")
        }
        
        
    }
    
    
}

