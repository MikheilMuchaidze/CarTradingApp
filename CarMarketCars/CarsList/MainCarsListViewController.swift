import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class MainCarsListViewController: UIViewController {
    
    //MARK: - Clean Components

    
    
    //MARK: - Fields

    var carsdb = Firestore.firestore().collection(FirebaseCollectionNames.cars.rawValue)
    let carsStorageRef = Storage.storage().reference()
    var carsList = [Car]()
    var searchingCarsList = [Car]()
    
    //MARK: - Outlets

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activeUserLbl: UILabel!
    @IBOutlet weak var goBackActionImage: UIImageView!
    @IBOutlet weak var userDetailsImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Object Lifecycle
    
    

    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Setup
    
    private func setup() {
        //flipped
        goBackActionImage.transform = CGAffineTransform(scaleX: -1, y: 1)
        //add actions for images
        addTapToGoBackToImage(image: goBackActionImage)
        addTapToGoToDetailsToImage(image: userDetailsImage)
        //delegates
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        searchBar.delegate = self
        //downloading data for tableview
        fetchSellableCars()
        //add function to reload tableview after swiping from top
        tablePullToRefresh()
        AuthService.currentUserInfo { [weak self] user in
            self?.activeUserLbl.text = user.email
        }
    }
    
    //MARK: - Actions
    
    @IBAction func uploadCarBtn(_ sender: Any) {
        guard let carUploadPage = storyboard?.instantiateViewController(withIdentifier: StoryboardName.newCar) as? NewCarUploadViewController else { return }
        carUploadPage.carUploadPageStatus = .AddingCar
        self.present(carUploadPage, animated: true)
    }
    
}


