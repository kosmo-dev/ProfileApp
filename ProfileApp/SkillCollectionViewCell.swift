//
//  SkillCollectionViewCell.swift
//  ProfileApp
//
//  Created by Вадим Кузьмин on 01.08.2023.
//

import UIKit

final class SkillCollectionViewCell: UICollectionViewCell {
    let title: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        title.textColor = .textColor
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    let deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.setTitle("", for: .normal)
        deleteButton.setImage(UIImage(named: "DeleteButton"), for: .normal)
        deleteButton.imageView?.contentMode = .scaleAspectFill
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        return deleteButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(_ text: String) {
        title.text = text
    }

    private func configureView() {
        backgroundColor = .background
        layer.cornerRadius = 12
        layer.masksToBounds = true

        addSubview(title)
        addSubview(deleteButton)

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),

            deleteButton.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 10),
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            deleteButton.widthAnchor.constraint(equalToConstant: 14),
            deleteButton.heightAnchor.constraint(equalToConstant: 14)
        ])
    }
}
