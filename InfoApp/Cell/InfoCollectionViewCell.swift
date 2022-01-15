//
//  InfoCollectionViewCell.swift
//  InfoApp
//
//  Created by Pavel Avlasov on 11.01.2022.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var age: UILabel!
    
    func configure(with infoModel: InfoModel) {
        self.name.text = infoModel.name
        self.age.text = String(infoModel.age)
        self.gender.text = infoModel.gender
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
