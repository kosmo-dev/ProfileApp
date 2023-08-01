//
//  HeaderCollectionView.swift
//  ProfileApp
//
//  Created by Вадим Кузьмин on 01.08.2023.
//

import UIKit

protocol HeaderCollectionViewDelegate: AnyObject {
    func didTapHeaderButton()
}

final class HeaderCollectionView: UICollectionReusableView {
    weak var delegate: HeaderCollectionViewDelegate?

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
        button.addTarget(nil, action: #selector(didTapButton), for: .touchUpInside)
        button.isHidden = true
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

    func configureHeader(with text: String, isButtonVisible: Bool) {
        title.text = text
        if isButtonVisible {
            button.setImage(UIImage(named: "EditButton"), for: .normal)
            button.isHidden = false
        }
    }

    private func configureView() {
        addSubview(title)
        addSubview(button)

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),

            button.leadingAnchor.constraint(equalTo: title.trailingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 24),
            button.widthAnchor.constraint(equalToConstant: 24)
        ])
    }

    @objc private func didTapButton() {
        delegate?.didTapHeaderButton()
    }
}
