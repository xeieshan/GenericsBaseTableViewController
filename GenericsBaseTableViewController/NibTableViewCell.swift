

import UIKit
struct MOPerson {
    let name,genderAge : String 
}
class NibTableViewCell: BaseTableViewCell<MOPerson> {
    
    override var item: MOPerson! {
        didSet {
            lblName.text = item.name
            lblGenderAge.text = item.genderAge
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblGenderAge: UILabel!
    
    // MARK: - Initial Setup
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

