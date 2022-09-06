import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RegisterScreenViewController: UIViewController {
    
    //MARK: Fields
        
    var handle: AuthStateDidChangeListenerHandle?
    
    //MARK: Outlets
    
    @IBOutlet weak var UserNameTxt: UITextField!
    @IBOutlet weak var UserSurnameTxt: UITextField!
    @IBOutlet weak var UserEmailTxt: UITextField!
    @IBOutlet weak var UserPasswordTxt: UITextField!
    @IBOutlet weak var UserRepeatPassTxt: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adding toggle button to password for showing and hiding text
        
        //TODO: ar mushaoooobs es deda....
//        UserPasswordTxt.enablePasswordToggle()
//        UserRepeatPassTxt.enablePasswordToggle()
        
        indicator.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
            
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            if user == nil {
                print("no user please register")
            } else {
                self.UserNameTxt.text = nil
                self.UserSurnameTxt.text = nil
                self.UserEmailTxt.text = nil
                self.UserPasswordTxt.text = nil
                self.UserRepeatPassTxt.text = nil
            }
            
            print("addStateDidChangeListener - RegisterPage")
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        UserNameTxt.text = nil
        UserSurnameTxt.text = nil
        UserEmailTxt.text = nil
        UserPasswordTxt.text = nil
        UserRepeatPassTxt.text = nil
        
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
        print("removeStateDidChangeListener - RegisterPage")

    }
    
    //MARK: Actions
    
    //clear all fields
    @IBAction func resetAllFields(_ sender: Any) {
        
        let allTxtFields = [UserEmailTxt, UserPasswordTxt, UserRepeatPassTxt, UserNameTxt, UserSurnameTxt]
        allTxtFields.forEach { elem in
            elem?.text?.removeAll()
        }
        
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
                
        if validateIfEmpty() && validateIfPasswordMatch() && validateIfPassword(str: UserPasswordTxt.text!) && validateIfEmailCorrectForm(str: UserEmailTxt.text!) {
            
            indicator.isHidden = false
            indicator.startAnimating()
            
            guard
                let name = UserNameTxt.text,
                let surname = UserSurnameTxt.text,
                let email = UserEmailTxt.text,
                let password = UserPasswordTxt.text,
                !name.isEmpty,
                !surname.isEmpty,
                !email.isEmpty,
                !password.isEmpty
            else { return }
            
            Auth.auth().createUser(withEmail: UserEmailTxt.text!, password: UserPasswordTxt.text!) { authResult, error in
                
                if error != nil {
                    self.alertPopUp(title: "Failure", message: "\(error!.localizedDescription)", okTitle: "Try again")
                    self.indicator.isHidden = true
                    self.indicator.stopAnimating()
                    return
                } else {
                    let db = Firestore.firestore()
                    db.collection(FirebaseCollectionNames.users.rawValue).document("\(authResult?.user.email ?? "")").setData([
                        "Uid": authResult!.user.uid,
                        "Name": name,
                        "Surname": surname,
                        "Email": email,
                        "Password": password
                    ]) { (error) in
                        if error != nil {
                            self.alertPopUp(title: "Database Error", message: "\(error?.localizedDescription ?? "")", okTitle: "Try Again")
                            self.indicator.isHidden = true
                            self.indicator.stopAnimating()
                        }
                    }
    
                    self.alertPopUp(title: "Congratulations", message: "Your user created!", okTitle: "Log In")
                    print("Successful sign up")
                    self.indicator.isHidden = true
                    self.indicator.stopAnimating()
                    self.tabBarController?.selectedIndex = 0
                }
            }
        }
    }
    
}

