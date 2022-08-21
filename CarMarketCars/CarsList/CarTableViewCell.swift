import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var helperView: UIView!
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carMarkLbl: UILabel!
    @IBOutlet weak var carModelLbl: UILabel!
    @IBOutlet weak var carYearLbl: UILabel!
    @IBOutlet weak var carLocationLbl: UILabel!
    @IBOutlet weak var carPriceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        helperView.layer.cornerRadius = 10
        carImage.layer.cornerRadius = 10
        carImage.layer.borderColor = UIColor.systemBlue.cgColor
        carImage.layer.borderWidth = 2
        carImage.backgroundColor = .clear


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
