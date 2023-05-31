//
//  TableViewCellIdentifier.swift
//  GuideChallenge
//
//  Created by Joseph Pecoraro on 5/31/23.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
