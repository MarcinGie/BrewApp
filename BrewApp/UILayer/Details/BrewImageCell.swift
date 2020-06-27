//
//  BrewImageCell.swift
//  BrewApp
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//
import UIKit
import EasyPeasy
import SDWebImage

class BrewImageCell: NiblessCell {
    private let beerImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(beerImageView)
        beerImageView.easy.layout(CenterX(), Width(100), Height(300), Top(5), Bottom(5))
    }
    
    func setup(imageURL: String) {
        beerImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder"))
    }
}
