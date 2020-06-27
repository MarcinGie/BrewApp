//
//  BrewContentCell.swift
//  BrewApp
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

import UIKit
import EasyPeasy



class BrewContentCell: NiblessCell {
    private let containerView = UIView()
    private let label = UILabel()
    private let iconView = UIImageView()
    
    func setup(viewModel: BrewContentCellViewModel) {
        contentView.addSubview(containerView)
        containerView.easy.layout(Top(5), Bottom(5), Left(10), Right(10))
        containerView.layer.cornerRadius = 5.0
        containerView.backgroundColor = .secondarySystemBackground
        
        if let imageName = viewModel.imageName {
            containerView.addSubview(iconView)
            iconView.easy.layout(Width(60),
                                 Height(100),
                                 Top(5).with(.high),
                                 Bottom(5).with(.high),
                                 Left(10))
            iconView.image = UIImage(named: imageName)
        }
        containerView.addSubview(label)
        label.easy.layout(Left(10).when { viewModel.imageName == nil },
                          Left(10).to(iconView, .right).when { viewModel.imageName != nil },
                          Right(10),
                          Top(5).with(.medium),
                          Bottom(5).with(.medium),
                          CenterY())
        label.text = viewModel.label
        label.textAlignment = viewModel.style.textAlignment
        label.font = .preferredFont(forTextStyle: viewModel.style.textStyle)
        label.numberOfLines = 0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        containerView.removeFromSuperview()
        label.removeFromSuperview()
        iconView.removeFromSuperview()
        contentView.easy.clear()
    }
}
