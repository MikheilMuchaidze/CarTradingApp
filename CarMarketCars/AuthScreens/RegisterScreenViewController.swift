import UIKit

class RegisterScreenViewController: UIViewController {
    
    @IBOutlet weak var UserEmailTxt: UITextField!
    @IBOutlet weak var UserPasswordTxt: UITextField!
    @IBOutlet weak var UserRepeatPassTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func resetAllFields(_ sender: Any) {
        let allTxtFields = [UserEmailTxt, UserPasswordTxt, UserRepeatPassTxt]
        allTxtFields.forEach { elem in
            elem?.text?.removeAll()
        }
        
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        
    }
    
    
}
