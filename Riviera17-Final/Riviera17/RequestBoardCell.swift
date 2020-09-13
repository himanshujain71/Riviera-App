//
//  RequestBoardCell.swift
//  Riviera17
//

//

import UIKit

class RequestBoardCell: UITableViewCell {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var eventRulesLabel: UITextView!
    @IBOutlet weak var eventDescLabel: UITextView!
    @IBOutlet weak var eventNameLabel: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
