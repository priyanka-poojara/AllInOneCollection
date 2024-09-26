//
//  CarouselCell.swift
//  IlaBankTask
//
//  Created by Neosoft on 29/08/24.
//

import UIKit

class CarouselCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var carouseImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        carouseImage.layer.cornerRadius = 20
        lblTitle.textColor = UIColor.title
    }
    
    func setListData(data: FinancialService) {
        lblTitle.text = data.typeTitle
        if let image = data.typeImage {
            switch image {
            case "a":
                carouseImage.image = UIImage(resource: .a)
            case "b":
                carouseImage.image = UIImage(resource: .b)
            case "c":
                carouseImage.image = UIImage(resource: .c)
            default: break
            }
        }
    }
    
}
