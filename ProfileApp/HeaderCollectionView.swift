//
//  HeaderCollectionView.swift
//  ProfileApp
//
//  Created by Вадим Кузьмин on 01.08.2023.
//

import UIKit

final class HeaderCollectionView: UICollectionReusableView {
    private let title: UILabel = {
        let title = UILabel()
        title.textColor = .textColor
        title.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureHeader() {
        title.text = "Мои навыки"
        button.setImage(UIImage(named: "EditButton"), for: .normal)
    }

    private func configureView() {
        addSubview(title)
        addSubview(button)

        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),

            button.leadingAnchor.constraint(equalTo: title.trailingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 24),
            button.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}
