//
//  ThreadCell.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/11/21.
//

import UIKit

class ThreadCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!

    func configCell() {
        title.text = "Threads"
    }

}
