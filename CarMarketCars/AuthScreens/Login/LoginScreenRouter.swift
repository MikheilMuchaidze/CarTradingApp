import UIKit

protocol LoginScreenRoutingLogic {
    func routeToMainVC()
}

final class LoginScreenRouter: LoginScreenRoutingLogic {
    
    //MARK: - Clean Components
    
    weak var viewController: LoginScreenViewController?
    
    // MARK: Routing
    
    func routeToMainVC() {
        let storyboard = UIStoryboard(name: StoryboardNames.mainPage, bundle: nil)
        guard let toMainMarketView = storyboard.instantiateViewController(withIdentifier: ViewControllerName.main) as? MainCarsListViewController else { return }
        guard let viewController = viewController else { return }
        navigateToMainVC(source: viewController, destination: toMainMarketView)
    }
    
    // MARK: Navigation
    
    private func navigateToMainVC(source: LoginScreenViewController, destination: UIViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
 
}

