//
//  ViewController.swift
//  ProfileApp
//
//  Created by Вадим Кузьмин on 01.08.2023.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - Private Properties
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var skills = ["MVI/MVVM", "Kotlin Coroutines", "Room", "OkHttp", "DataStore", "WorkManager", "custom view", "DataStore", "ООП и SOLID"]

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCells()
        configureView()
        configureConstraints()
    }

    // MARK: - Private Methods
    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func registerCells() {
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        collectionView.register(SkillCollectionViewCell.self, forCellWithReuseIdentifier: "SkillCollectionViewCell")
        collectionView.register(DescriptionCollectionViewCell.self, forCellWithReuseIdentifier: "DescriptionCollectionViewCell")
        collectionView.register(HeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionView")
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return skills.count
        } else {
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as? ProfileCollectionViewCell
            cell?.configureCell()
            return cell ?? UICollectionViewCell()
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillCollectionViewCell", for: indexPath) as? SkillCollectionViewCell
            cell?.configureCell(skills[indexPath.row])
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DescriptionCollectionViewCell", for: indexPath) as? DescriptionCollectionViewCell
            let text = "Experienced software engineer skilled in developing scalable and maintainable systems"
            cell?.configureCell(text)
            return cell ?? UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionView", for: indexPath) as? HeaderCollectionView
            view?.configureHeader(with: "Мои навыки")
            return view ?? UICollectionReusableView()
        } else if indexPath.section == 2 {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionView", for: indexPath) as? HeaderCollectionView
            view?.configureHeader(with: "О себе")
            return view ?? UICollectionReusableView()
        } else {
            return UICollectionReusableView()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height: 310)
        } else if indexPath.section == 1 {
            let width = skills[indexPath.row].width() + 24 * 3
            return CGSize(width: width, height: 44)
        } else {
            return CGSize(width: collectionView.bounds.width, height: 200)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 || section == 2 {
            return CGSize(width: collectionView.bounds.width, height: 54)
        } else {
            return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        } else {
            return .zero
        }
    }
}

