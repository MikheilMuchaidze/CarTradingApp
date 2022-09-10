import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

final class LoginScreenViewController: UIViewController {
    
    //MARK: - Clean Components
    

    
    //MARK: - Fields
    
    var handle: AuthStateDidChangeListenerHandle?
    
    //MARK: Outlets
    
    @IBOutlet weak var UserEmailTxt: UITextField!
    @IBOutlet weak var UserPasswordTxt: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // MARK: - Setup
    
    private func setup() {
        //adding toggle button to password for showing and hiding text
        UserPasswordTxt.enablePasswordToggle()
        indicator.isHidden = true
    }
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cleanAllFields()
    }
    
    //MARK: - Methods
    
    func cleanAllFields() {
        let allTxtFields = [UserEmailTxt, UserPasswordTxt]
        allTxtFields.forEach { elem in
            elem?.text?.removeAll()
        }
    }
    
    //MARK: - Actions

    @IBAction func signInBtn(_ sender: Any) {
        
        if validateIfEmpty() && validateIfEmailCorrectForm(str: UserEmailTxt.text!) {
            
            indicator.isHidden = false
            indicator.startAnimating()
            
            guard
                let email = UserEmailTxt.text,
                let password = UserPasswordTxt.text,
                !email.isEmpty,
                !password.isEmpty
            else { return }
            
            AuthServie.loginUser(withEmail: email, password: password) { [weak self] result, error in
                if let error = error, result == nil {
                    self?.alertPopUp(title: "Sign in failed", message: "\(error.localizedDescription)", okTitle: "Try again.")
                    self?.indicator.isHidden = true
                    self?.indicator.stopAnimating()
                } else {
                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "MainCarsListViewController") as! MainCarsListViewController
                    self?.indicator.isHidden = true
                    self?.indicator.stopAnimating()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        }
    }
    
}

//MARK: - protocol to ViewController


    

    
    
    
    
    

