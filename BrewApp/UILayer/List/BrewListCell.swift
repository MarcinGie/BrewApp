//
//  BrewListCell.swift
//  BrewApp
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

import EasyPeasy
import SDWebImage

class BrewListCell: NiblessCell {
    private let containerView = UIView()
    private let imageview = UIImageView()
    private let nameLabel = UILabel()
    private let abvLabel = UILabel()
    private let chevronImageview = UIImageView()
    
    func setup(viewModel: BrewListCellViewModel) {
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.easy.layout(Top(5), Bottom(5), Left(10), Right(10))
        containerView.layer.cornerRadius = 5
        containerView.backgroundColor = .secondarySystemBackground
        
        containerView.addSubview(imageview)
        imageview.easy.layout(Height(150), Width(50), Top(5), Bottom(5), Left(10))
        imageview.sd_setImage(with: URL(string: viewModel.imageURL), placeholderImage: UIImage(named: "placeholder"))
        
        containerView.addSubview(chevronImageview)
        chevronImageview.easy.layout(CenterY(), Right(10), Height(30), Width(20))
        chevronImageview.image = UIImage(systemName: "chevron.right")?.withTintColor(UIColor.secondaryLabel)
        
        containerView.addSubview(nameLabel)
        nameLabel.easy.layout(CenterY(-10), Left(20).to(imageview, .right), Right(5).to(chevronImageview, .left))
        nameLabel.text = viewModel.title
        nameLabel.font = .preferredFont(forTextStyle: .headline)
        
        containerView.addSubview(abvLabel)
        abvLabel.easy.layout(CenterY(10), Left(20).to(imageview))
        abvLabel.text = viewModel.subtitle
        abvLabel.font = .preferredFont(forTextStyle: .subheadline)
    }
}
