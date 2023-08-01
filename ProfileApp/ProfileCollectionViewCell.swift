//
//  ProfileCollectionViewCell.swift
//  ProfileApp
//
//  Created by Вадим Кузьмин on 01.08.2023.
//

import UIKit

final class ProfileCollectionViewCell: UICollectionViewCell {

    private let title: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        title.textColor = .textColor
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private let photo: UIImageView = {
        let photo = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        photo.contentMode = .scaleAspectFill
        photo.image = UIImage(named: "Photo")
        photo.layer.cornerRadius = 60
        photo.layer.masksToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()

    private let name: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        name.textColor = .textColor
        name.numberOfLines = 0
        name.textAlignment = .center
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private let descriptionLabel: UILabel = {
        let description = UILabel()
        description.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        description.textColor = .textGrayColor
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()

    private let geotagImage: UIImageView = {
        let geotagImage = UIImageView()
        geotagImage.image = UIImage(named: "Geotag")
        geotagImage.translatesAutoresizingMaskIntoConstraints = false
        return geotagImage
    }()

    private let geotagLabel: UILabel = {
        let geotagLabel = UILabel()
        geotagLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        geotagLabel.textColor = .textGrayColor
        geotagLabel.translatesAutoresizingMaskIntoConstraints = false
        return geotagLabel
    }()

    private let stackview: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell() {
        title.text = "Профиль"
        name.text = "Иванов Иван Иванович"
        descriptionLabel.text = "Middle iOS-разработчик, опыт более 2-х лет"
        geotagLabel.text = "Воронеж"
    }

    private func configureView() {
        backgroundColor = .background
        [geotagImage, geotagLabel].forEach { stackview.addArrangedSubview($0) }
        [title, photo, name, descriptionLabel, stackview].forEach { addSubview($0) }
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),

            photo.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 42),
            photo.centerXAnchor.constraint(equalTo: centerXAnchor),
            photo.heightAnchor.constraint(equalToConstant: 120),
            photo.widthAnchor.constraint(equalToConstant: 120),

            name.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 16),
            name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),

            descriptionLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),

            stackview.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 2),
            stackview.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -19)
        ])
    }
}
