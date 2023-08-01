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
        deleteButton.isHidden = true
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        return deleteButton
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(viewModel: SkillCellViewModel, visibleButtons: Bool) {
        title.text = viewModel.title
        if visibleButtons {
            deleteButton.isHidden = false
            stackView.addArrangedSubview(deleteButton)
        } else {
            deleteButton.isHidden = true
            stackView.removeArrangedSubview(deleteButton)
        }
    }

    private func configureView() {
        backgroundColor = .background
        layer.cornerRadius = 12
        layer.masksToBounds = true

        addSubview(stackView)

        stackView.addArrangedSubview(title)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),

            deleteButton.widthAnchor.constraint(equalToConstant: 14),
            deleteButton.heightAnchor.constraint(equalToConstant: 14)
        ])
    }
}
