import UIKit

final class RegisterScreenViewController: UIViewController {
    
    //MARK: - Fields
        
    
    //MARK: - Outlets
    
    @IBOutlet weak var UserNameTxt: UITextField!
    @IBOutlet weak var UserSurnameTxt: UITextField!
    @IBOutlet weak var UserEmailTxt: UITextField!
    @IBOutlet weak var UserPasswordTxt: UITextField!
    @IBOutlet weak var UserRepeatPassTxt: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
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
        //adding toggle button to password for showing and hiding text
        UserPasswordTxt.enablePasswordToggle()
        loader(isLoading: false)
    }
    
    //MARK: - Methods
    
    private func cleanAllFields() {
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
        
        guard
            let name = UserNameTxt.text,
            let surname = UserSurnameTxt.text,
            let email = UserEmailTxt.text,
            let password = UserPasswordTxt.text
        else { return }
        
        if validateIfEmpty() && validateIfPasswordMatch() && validateIfPassword(str: UserPasswordTxt.text!) && validateIfEmailCorrectForm(str: email) {
        
            loader(isLoading: true)
            
            AuthService.registerUser(withEmail: email, password: password) { [weak self] result, error in
                
                self?.loader(isLoading: false)
                
                let registeredUser = User(name: name, surname: surname, password: password, email: email, uid: result?.user.uid ?? "")
                
                if error != nil {
                    self?.alertPopUp(title: RegisterValidationTitles.failedRegistration, message: "\(error!.localizedDescription)", okTitle: RegisterValidationOkTitles.tryAgainTitle)
                    return
                } else {
                    
                    AuthService.registerUserInDB(with: registeredUser)
                    
                    self?.alertPopUp(title: RegisterValidationTitles.successfulRegistration, message: RegisterValidationMessages.successfulRegistrationMassage, okTitle: RegisterValidationOkTitles.logInAfterRegistratoin)
                    self?.tabBarController?.selectedIndex = 0
                }
            }
        }
        
    }
    
}

