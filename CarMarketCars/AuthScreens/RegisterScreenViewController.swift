import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RegisterScreenViewController: UIViewController {
    
    //MARK: - Fields
        
    var handle: AuthStateDidChangeListenerHandle?
    let db = Firestore.firestore()
    
    //MARK: - Outlets
    
    @IBOutlet weak var UserNameTxt: UITextField!
    @IBOutlet weak var UserSurnameTxt: UITextField!
    @IBOutlet weak var UserEmailTxt: UITextField!
    @IBOutlet weak var UserPasswordTxt: UITextField!
    @IBOutlet weak var UserRepeatPassTxt: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    //MARK: - Setup
    
    private func setup() {
        //adding toggle button to password for showing and hiding text
        //TODO: - ar mushaoooobs es deda....
        UserPasswordTxt.enablePasswordToggle()
        indicator.isHidden = true
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cleanAllFields()
    }
    
    //MARK: - Methods
    
    func cleanAllFields() {
        let allTxtFields = [UserNameTxt, UserSurnameTxt, UserEmailTxt, UserPasswordTxt, UserRepeatPassTxt]
        allTxtFields.forEach { elem in
            elem?.text?.removeAll()
        }
    }
    
    //MARK: - Actions
    
    //clear all fields
    @IBAction func resetAllFields(_ sender: Any) {
        cleanAllFields()
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
            
            AuthServie.registerUser(withEmail: email, password: password) { [weak self] result, error in
                
                let registeredUser = User(name: name, surname: surname, password: password, email: email, uid: result?.user.uid ?? "")
                
                if error != nil {
                    self?.alertPopUp(title: "Failure", message: "\(error!.localizedDescription)", okTitle: "Try again")
                    self?.indicator.isHidden = true
                    self?.indicator.stopAnimating()
                    return
                } else {
                    self?.db.collection(FirebaseCollectionNames.users.rawValue).document("\(result?.user.email ?? "")").setData(
                        
                        registeredUser.toDatabaseType()
                        
                        /*[
                        "Uid": result!.user.uid,
                        "Name": name,
                        "Surname": surname,
                        "Email": email,
                        "Password": password
                    ]*/) { (error) in
                        if error != nil {
                            self?.alertPopUp(title: "Database Error", message: "\(error?.localizedDescription ?? "")", okTitle: "Try Again")
                            self?.indicator.isHidden = true
                            self?.indicator.stopAnimating()
                        }
                    }
                    
                    self?.alertPopUp(title: "Congratulations", message: "Your user created!", okTitle: "Log In")
                    print("Successful sign up")
                    self?.indicator.isHidden = true
                    self?.indicator.stopAnimating()
                    self?.tabBarController?.selectedIndex = 0
                }
            }
        }
        
    }
    
}

