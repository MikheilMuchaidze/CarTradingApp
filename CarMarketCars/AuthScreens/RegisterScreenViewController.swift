import UIKit

final class RegisterScreenViewController: UIViewController, LoadableView {
    
    //MARK: - Fields
        
    
    //MARK: - Outlets
    
    @IBOutlet weak var UserNameTxt: UITextField!
    @IBOutlet weak var UserSurnameTxt: UITextField!
    @IBOutlet weak var UserEmailTxt: UITextField!
    @IBOutlet weak var UserPasswordTxt: UITextField!
    @IBOutlet weak var UserRepeatPassTxt: UITextField!
    var loader = UIActivityIndicatorView()

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
        setupLoader()
        //adding toggle button to password for showing and hiding text
        UserPasswordTxt.enablePasswordToggle()
    }
    
    func setupLoader() {
        view.addSubview(loader)
        loader.center(inView: view)
    }
    
    //MARK: - Methods
    
    private func cleanAllFields() {
        [UserNameTxt, UserSurnameTxt, UserEmailTxt, UserPasswordTxt, UserRepeatPassTxt].clearFields()
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
            
            FirebaseAuth.registerUser(withEmail: email, password: password) { [weak self] result, error in
                self?.loader(isLoading: false)
                let registeredUser = User(name: name, surname: surname, password: password, email: email, uid: result?.user.uid ?? "")
                if error != nil {
                    self?.alertPopUp(title: RegisterValidationTitles.failedRegistration, message: "\(error!.localizedDescription)", okTitle: RegisterValidationOkTitles.tryAgainTitle)
                    return
                } else {
                    FirebaseDatabaseUpload.registerUserInDB(with: registeredUser)
                    self?.alertPopUp(title: RegisterValidationTitles.successfulRegistration, message: RegisterValidationMessages.successfulRegistrationMassage, okTitle: RegisterValidationOkTitles.logInAfterRegistratoin)
                    self?.tabBarController?.selectedIndex = 0
                }
            }
        }
        
    }
    
}

