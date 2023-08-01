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
    
    func configureCell() {
        self.aboutText.text = "Занимаюсь разработкой на iOS на протяжении двух лет: за это время программирование из хобби и самостоятельного изучения по профильной литературе и видео-курсам стало моей текущей карьерной целью. Сейчас я прохожу специализированные курсы на онлайн-платформах, веду несколько домашних проектов и участвую в жизни местного iOS-комьюнити."
    }

    func configureView() {
        addSubview(aboutText)

        NSLayoutConstraint.activate([
            aboutText.topAnchor.constraint(equalTo: topAnchor),
            aboutText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            aboutText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
