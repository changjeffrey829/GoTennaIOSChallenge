//
//  DetailLocationViewModel.swift
//  GoTennaIOSChallenge
//
//  Created by Jeffrey Chang on 5/20/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

class DetailLocationViewModel {
    private var position: Position
    init(position: Position) {
        self.position = position
    }
    
    func nameAttributedString() -> NSAttributedString {
        return getAttributedString(text: position.name ?? "")
    }
    
    func descriptAttributedString() -> NSAttributedString {
        return getAttributedString(text: position.descript ?? "")
    }
    
    private func getAttributedString(text: String) -> NSAttributedString {
        let fgColor = UIColor.brown
        if let font = UIFont(name: "MarkerFelt-Wide", size: 16) {
            let attributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: fgColor])
            return attributedString
        } else {
            let attributedString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: fgColor])
            return attributedString
        }
    }
}
