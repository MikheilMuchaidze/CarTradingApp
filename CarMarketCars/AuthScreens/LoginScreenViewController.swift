import UIKit

final class LoginScreenViewController: UIViewController {
    
    //MARK: - Clean Components
    
    
    //MARK: - Fields
    
    
    //MARK: Outlets
    
    @IBOutlet weak var UserEmailTxt: UITextField!
    @IBOutlet weak var UserPasswordTxt: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    //MARK: - Object Lifecycle

    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cleanAllFields()
    }
    
    // MARK: - Setup
    
    private func setup() {
        //adding toggle button to password for showing and hiding text
        UserPasswordTxt.enablePasswordToggle()
        loader(isLoading: false)
    }
    
    //MARK: - Methods
    
    private func cleanAllFields() {
        let allTxtFields = [UserEmailTxt, UserPasswordTxt]
        allTxtFields.forEach { elem in
            elem?.text?.removeAll()
        }
    }
    
    //MARK: - Actions
    
    @IBAction func signInBtn(_ sender: Any) {
        
        guard
            let email = UserEmailTxt.text,
            let password = UserPasswordTxt.text
        else { return }
        
        if validateIfEmpty() && validateIfEmailCorrectForm(str: email) {
            
            loader(isLoading: true)
            
            FirebaseService.loginUser(withEmail: email, password: password) { [weak self] result, error in
                self?.loader(isLoading: false)
                if let error = error, result == nil {
                    self?.alertPopUp(title: LoginValidationTitles.authFailed, message: "\(error.localizedDescription)", okTitle: LoginValidationOkTitles.tryAgainTitle)
                } else {
                    guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: StoryboardName.main) as? MainCarsListViewController else { return }
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        }
    }
    
}

//MARK: - protocol to ViewController








