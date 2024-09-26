//
//  CarouselListCell.swift
//  IlaBankTask
//
//  Created by Neosoft on 30/08/24.
//

import UIKit

class CarouselListCell: UICollectionViewCell {

    @IBOutlet weak var ivListItem: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCell()
    }
    
    private func configCell() {
        self.layer.cornerRadius = 25
        
        self.backgroundColor = UIColor.list
        lblTitle.textColor = UIColor.white.withAlphaComponent(0.8)
        lblDescription.textColor = UIColor.white.withAlphaComponent(0.5)
    }
    
    func setCarouselListData(data: ServiceDetail) {
        if let url = URL(string: data.image ?? "") {
            self.ivListItem.loadImage(from: url)
        }
        self.lblTitle.text = data.title
        self.lblDescription.text = data.subtitle
    }
    
}
