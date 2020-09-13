//
//  ListTableViewCell.swift
//  Riviera17
//
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var chapterName: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
