import UIKit


class StartingScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func StartBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StartingTabBarController") as! StartingTabBarController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    


}
