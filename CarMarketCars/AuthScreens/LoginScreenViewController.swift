import UIKit

final class LoginScreenViewController: UIViewController, LoadableView {
    
    //MARK: - Clean Components
    
    
    
    //MARK: - Fields
    
    var loader = UIActivityIndicatorView()
    
    //MARK: Outlets
    
    @IBOutlet weak var userEmailTxt: UITextField!
    @IBOutlet weak var userPasswordTxt: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    //MARK: - Object Lifecycle
    
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        [userEmailTxt, userPasswordTxt].clearFields()
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupLoader()
        //adding toggle button to password for showing and hiding text
        userPasswordTxt.enablePasswordToggle()
        loader(isLoading: false)
    }
    
    private func setupLoader() {
        view.addSubview(loader)
        loader.center(inView: view)
    }
    
    //MARK: - Methods
    
    
    
    //MARK: - Actions
    
    @IBAction func signInBtn(_ sender: Any) {
        
        guard
            let email = userEmailTxt.text,
            let password = userPasswordTxt.text
        else { return }
        
        let ifEmptyValidation = [userEmailTxt, userPasswordTxt]
        
        if validateIfEmpty(for: ifEmptyValidation, errorPopUpModel: PredefinedAlerMessages.ifEmptyError) && validateEmailForm(for: email, errorPopUpModel: PredefinedAlerMessages.incorrectEmailError) {
            loader(isLoading: true)
            FirebaseAuth.loginUser(withEmail: email, password: password) { [weak self] result, error in
                self?.loader(isLoading: false)
                if let error = error, result == nil {
                    self?.alertPopUp(title: AuthValidationAndAlert.ValidationTitles.signInFailed, message: "\(error.localizedDescription)", okTitle: AuthValidationAndAlert.ValidationOkTitles.tryAgain)
                } else {
                    let storyboard = UIStoryboard(name: StoryboardNames.mainPage, bundle: nil)
                    guard let toMainMarketView = storyboard.instantiateViewController(withIdentifier: ViewControllerName.main) as? MainCarsListViewController else { return }
                    self?.navigationController?.pushViewController(toMainMarketView, animated: true)
                }
            }
        }
        
    }
    
}



