import UIKit

final class LoginScreenViewController: UIViewController, LoadableView {
    
    //MARK: - Clean Components
    
    
    //MARK: - Fields
    
    var loader = UIActivityIndicatorView()
    
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
        [UserEmailTxt, UserPasswordTxt].clearFields()
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupLoader()
        //adding toggle button to password for showing and hiding text
        UserPasswordTxt.enablePasswordToggle()
        loader(isLoading: false)
    }
    
    func setupLoader() {
        view.addSubview(loader)
        loader.center(inView: view)
    }
    
    //MARK: - Methods
    
    
    //MARK: - Actions
    
    @IBAction func signInBtn(_ sender: Any) {
        
        guard
            let email = UserEmailTxt.text,
            let password = UserPasswordTxt.text
        else { return }
        
        if validateIfEmpty() && validateIfEmailCorrectForm(str: email) {
            loader(isLoading: true)
            FirebaseAuth.loginUser(withEmail: email, password: password) { [weak self] result, error in
                self?.loader(isLoading: false)
                if let error = error, result == nil {
                    self?.alertPopUp(title: LoginValidationTitles.authFailed, message: "\(error.localizedDescription)", okTitle: LoginValidationOkTitles.tryAgainTitle)
                } else {
                    let storyboard = UIStoryboard(name: StoryboardNames.mainPage, bundle: nil)
                    guard let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerName.main) as? MainCarsListViewController else { return }
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
}



