//
//  CollectionViewCell.swift
//  LottoMachine
//
//  Created by lee on 2018. 2. 23..
//  Copyright © 2018년 smith. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {


    
    @IBOutlet weak var lottoLabel: UILabel!
    @IBOutlet weak var selectionImage: UIImageView!
    
    var isEditing: Bool = false {
        didSet {
            selectionImage.isHidden = !isEditing
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isEditing {
                selectionImage.image = isSelected ? UIImage(named: "checked") : UIImage(named: "unchecked")
            }
        }
    }
}
