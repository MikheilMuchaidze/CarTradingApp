import UIKit

final class StartingScreen: UIViewController {
    
    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    
    @IBAction func StartBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: StoryboardNames.main, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerName.mainTabBar) as? StartingTabBarController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
