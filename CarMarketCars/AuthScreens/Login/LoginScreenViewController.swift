import UIKit

protocol LoginScreenDisplayLogic: AnyObject {
    func displayUserValidationOutcome(viewModel: LoginScreen.UserValidation.ViewModel)
    func goToMainView()
}

final class LoginScreenViewController: UIViewController, LoadableView {
    
    //MARK: - Clean Components
    
    private var interactor: LoginScreenBusinessLogic?
    private var router: LoginScreenRoutingLogic?
    
    //MARK: - Fields
    
    var loader = UIActivityIndicatorView()
    
    //MARK: - Outlets
    
    @IBOutlet private weak var userEmailTxt: UITextField!
    @IBOutlet private weak var userPasswordTxt: UITextField!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    //MARK: - Object Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupRelationships()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupRelationships()
    }
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        clearFields()
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupLoader()
        //adding toggle button to password for showing and hiding text
        userPasswordTxt.enablePasswordToggle()
        loader(isLoading: false)
        self.dismissKeyboard()
        keyboardUIMovingLogic()
    }
    
    private func setupLoader() {
        view.addSubview(loader)
        loader.center(inView: view)
    }
    
    private func setupRelationships() {
        let viewController = self
        let interactor = LoginScreenInteractor()
        let presenter = LoginScreenPresenter()
        let router = LoginScreenRouter()
        let worker = LoginScreenWorker()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    //MARK: - Methods
    
    private func clearFields() {
        [userEmailTxt, userPasswordTxt].clearFields()
    }
    
    //MARK: - Actions
    
    @IBAction private func signInBtn(_ sender: Any) {
        loader(isLoading: true)
        let validationRequest = LoginScreen.UserValidation.Request(email: userEmailTxt.text, password: userPasswordTxt.text)
        interactor?.validateUser(request: validationRequest)
    }
    
}

//MARK: - extansion for display logic protocol

extension LoginScreenViewController: LoginScreenDisplayLogic {
    
    func displayUserValidationOutcome(viewModel: LoginScreen.UserValidation.ViewModel) {
        alertPopUp(title: AuthValidationAndAlert.ValidationTitles.signInFailed, message: viewModel.outcome, okTitle: AuthValidationAndAlert.ValidationOkTitles.ok)
        loader(isLoading: false)
    }
    
    func goToMainView() {
        router?.routeToMainVC()
        loader(isLoading: false)
    }
    
}
