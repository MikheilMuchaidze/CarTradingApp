import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class StartingScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func StartBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StartingTabBarController") as! StartingTabBarController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    


}
