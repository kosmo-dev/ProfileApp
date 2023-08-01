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
        let collectionView = UICollectionView(frame: .zero)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureConstraints()
    }

    // MARK: - Private Methods
    private func configureView() {
        navigationItem.title = "Profile"
        view.backgroundColor = .background
        view.addSubview(collectionView)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func registerCells() {
        
    }
}

