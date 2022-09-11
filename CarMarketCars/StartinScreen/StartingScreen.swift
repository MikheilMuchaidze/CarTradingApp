import UIKit

class StartingScreen: UIViewController {
    
    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    
    @IBAction func StartBtn(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: StoryboardName.mainTabBar) as? StartingTabBarController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
