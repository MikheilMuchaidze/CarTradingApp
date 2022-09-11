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
    var handle: AuthStateDidChangeListenerHandle?
    
    //MARK: - Outlets

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activeUserLbl: UILabel!
    @IBOutlet weak var goBackActionImage: UIImageView!
    @IBOutlet weak var userDetailsImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Object Lifecycle
    
    
    
    //MARK: - Setup
    
    private func setup() {
        
        //flipped
        goBackActionImage.transform = CGAffineTransform(scaleX: -1, y: 1)
        
        addTapToGoBackToImage(image: goBackActionImage)
        addTapToGoToDetailsToImage(image: userDetailsImage)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
                
        searchBar.delegate = self
        
        fetchSellableCars()
        
        tablePullToRefresh()
        
    }

    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener({ [weak self] auth, user in
            
            if user != nil {
                self?.activeUserLbl.text = user?.email
            }

            print("addStateDidChangeListener - MainCarsListViewController")
        })
                
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    //MARK: - Actions
    
    @IBAction func uploadCarBtn(_ sender: Any) {
        let carUploadPage = storyboard?.instantiateViewController(withIdentifier: "NewCarUploadViewController") as! NewCarUploadViewController
        carUploadPage.carUploadPageStatus = .AddingCar
        self.present(carUploadPage, animated: true)
    }
    
}


