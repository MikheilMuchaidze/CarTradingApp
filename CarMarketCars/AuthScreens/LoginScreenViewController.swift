import UIKit

class LoginScreenViewController: UIViewController {
    
    @IBOutlet weak var UserEmailTxt: UITextField!
    @IBOutlet weak var UserPasswordTxt: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signInBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainCarsListViewController") as! MainCarsListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
