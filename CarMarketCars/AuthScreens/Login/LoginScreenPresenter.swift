import UIKit

protocol LoginScreenPresentationLogic {
    func userValidationOutcome(response: LoginScreen.UserValidation.Response)
}

final class LoginScreenPresenter {
    
    //MARK: - Clean Components
    
    weak var viewController: LoginScreenDisplayLogic?
    
}

//MARK: - extansion for display logic protocol

extension LoginScreenPresenter: LoginScreenPresentationLogic {
    
    func userValidationOutcome(response: LoginScreen.UserValidation.Response) {
        let viewModel = LoginScreen.UserValidation.ViewModel(outcome: response.outcome)
        response.isError ? viewController?.displayUserValidationOutcome(viewModel: viewModel) : viewController?.goToMainView()
    }
    
}
