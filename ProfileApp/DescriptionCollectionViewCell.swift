//
//  DescriptionCollectionViewCell.swift
//  ProfileApp
//
//  Created by Вадим Кузьмин on 01.08.2023.
//

import UIKit

final class DescriptionCollectionViewCell: UICollectionViewCell {
    private let aboutText: UILabel = {
        let aboutText = UILabel()
        aboutText.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        aboutText.textColor = .textColor
        aboutText.numberOfLines = 0
        aboutText.translatesAutoresizingMaskIntoConstraints = false
        return aboutText
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ text: String) {
        self.aboutText.text = text
    }

    func configureView() {
        addSubview(aboutText)

        NSLayoutConstraint.activate([
            aboutText.topAnchor.constraint(equalTo: topAnchor),
            aboutText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            aboutText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
//            aboutText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
