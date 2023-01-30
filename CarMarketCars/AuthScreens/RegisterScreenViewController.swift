import UIKit

final class RegisterScreenViewController: UIViewController, LoadableView {
    
    //MARK: - Fields
    
    var loader = UIActivityIndicatorView()
    
    //MARK: - Outlets
    
    @IBOutlet private weak var userNameTxt: UITextField!
    @IBOutlet private weak var userSurnameTxt: UITextField!
    @IBOutlet private weak var userEmailTxt: UITextField!
    @IBOutlet private weak var userPasswordTxt: UITextField!
    @IBOutlet private weak var userRepeatPassTxt: UITextField!
    
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
        userPasswordTxt.enablePasswordToggle()
        userRepeatPassTxt.enablePasswordToggle()
        self.dismissKeyboard()
        keyboardUIMovingLogic()
        addSwipeGestures()
    }
    
    private func setupLoader() {
        view.addSubview(loader)
        loader.center(inView: view)
    }
    
    //MARK: - Methods
    
    private func cleanAllFields() {
        [userNameTxt, userSurnameTxt, userEmailTxt, userPasswordTxt, userRepeatPassTxt].clearFields()
    }
    
    //MARK: - Actions
    
    //clear all fields
    @IBAction private func resetAllFields(_ sender: Any) {
        cleanAllFields()
    }
    
    @IBAction private func signUpBtn(_ sender: Any) {
        
        guard
            let name = userNameTxt.text,
            let surname = userSurnameTxt.text,
            let email = userEmailTxt.text,
            let password = userPasswordTxt.text
        else { return }
        let ifEmptyValidation = [userNameTxt, userSurnameTxt, userEmailTxt, userPasswordTxt, userRepeatPassTxt]
        let passwordMatchValidation = [userPasswordTxt, userRepeatPassTxt]
        
        if validateIfEmpty(for: ifEmptyValidation, errorPopUpModel: PredefinedAlerMessages.ifEmptyError) && validatePasswordMatch(for: passwordMatchValidation, errorPopUpModel: PredefinedAlerMessages.passwordMismatch) && validatePassword(for: password) && validateEmailForm(for: email, errorPopUpModel: PredefinedAlerMessages.incorrectEmailError) {
            loader(isLoading: true)
            FirebaseAuth.registerUser(withEmail: email, password: password) { [weak self] result, error in
                self?.loader(isLoading: false)
                let registeredUser = User(name: name, surname: surname, password: password, email: email, uid: result?.user.uid ?? "")
                if error != nil {
                    self?.alertPopUp(title: AuthValidationAndAlert.ValidationTitles.registerFailed, message: "\(error?.localizedDescription ?? "")", okTitle: AuthValidationAndAlert.ValidationOkTitles.tryAgain)
                    return
                } else {
                    FirebaseDatabaseUpload.registerUserInDB(with: registeredUser)
                    self?.alertPopUpWithModel(errorPopUpModel: PredefinedAlerMessages.registerSuccess)
                    self?.tabBarController?.selectedIndex = 0
                }
            }
        }
        
    }
    
}

