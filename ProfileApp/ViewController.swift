//
//  ViewController.swift
//  ProfileApp
//
//  Created by Вадим Кузьмин on 01.08.2023.
//

import UIKit

protocol ViewControllerProtocol: AnyObject {
    var collectionViewWidth: CGFloat { get }
    var isEditingMode: Bool { get }
    func reloadCollectionView()
}

final class ViewController: UIViewController {
    var collectionViewWidth: CGFloat {
        collectionView.bounds.width - 16 * 2
    }
    
    // MARK: - Private Properties
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var presenter: PresenterProtocol
    private(set) var isEditingMode = false

    // MARK: - Initializers
    init(presenter: PresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewController = self
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCells()
        configureView()
        configureConstraints()
        view.layoutIfNeeded()
        presenter.createViewModel()
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
        collectionView.register(AddNewCollectionViewCell.self, forCellWithReuseIdentifier: "AddNewCollectionViewCell")
        collectionView.register(TransparentCollectionViewCell.self, forCellWithReuseIdentifier: "TransparentCollectionViewCell")
        collectionView.register(HeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SkillsHeaderCollectionView")
        collectionView.register(HeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AboutHeaderCollectionView")
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return presenter.skillsViewModel.count
        } else {
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var collectionViewCell: UICollectionViewCell?

        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as? ProfileCollectionViewCell
            cell?.configureCell()
            collectionViewCell = cell

        } else if indexPath.section == 1 {
            if isEditingMode && indexPath.row == presenter.skillsViewModel.count - 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddNewCollectionViewCell", for: indexPath) as? AddNewCollectionViewCell
                collectionViewCell = cell

            } else {
                let isTransparent = presenter.skillsViewModel[indexPath.row].isTransparent
                if isTransparent {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransparentCollectionViewCell", for: indexPath) as? TransparentCollectionViewCell
                    collectionViewCell = cell

                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillCollectionViewCell", for: indexPath) as? SkillCollectionViewCell
                    cell?.configureCell(viewModel: presenter.skillsViewModel[indexPath.row], visibleButtons: isEditingMode)
                    cell?.delegate = self
                    collectionViewCell = cell
                }
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DescriptionCollectionViewCell", for: indexPath) as? DescriptionCollectionViewCell
            let text = "Experienced software engineer skilled in developing scalable and maintainable systems"
            cell?.configureCell(text)
            collectionViewCell = cell
        }

        return collectionViewCell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SkillsHeaderCollectionView", for: indexPath) as? HeaderCollectionView
            view?.delegate = self
            view?.configureHeader(with: "Мои навыки", isButtonVisible: true, isEditingMode: isEditingMode)
            return view ?? UICollectionReusableView()

        } else if indexPath.section == 2 {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AboutHeaderCollectionView", for: indexPath) as? HeaderCollectionView
            view?.configureHeader(with: "О себе", isButtonVisible: false, isEditingMode: isEditingMode)
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
            let width = presenter.skillsViewModel[indexPath.row].width
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

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditingMode, indexPath.row == presenter.skillsViewModel.count - 1 {
            showAlertController()
        }
    }

    private func showAlertController() {
        let alertController = UIAlertController(title: "Добавление навыка", message: "Введите название навыка, которым вы владеете", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .default)
        let add = UIAlertAction(title: "Добавить", style: .default) { [weak self] _ in
            guard let self else {
                return
            }
            self.addNewSkillFromTextFieldInAlert(alertController)
        }
        alertController.addAction(cancel)
        alertController.addAction(add)
        alertController.addTextField { textField in
            textField.placeholder = "Введите название"
        }
        present(alertController, animated: true)
    }

    private func addNewSkillFromTextFieldInAlert(_ alertController: UIAlertController) {
        guard let textField = alertController.textFields?.first,
              let text = textField.text
        else {
            return
        }
        presenter.addNewSkill(text)
    }
}

// MARK: - HeaderCollectionViewDelegate
extension ViewController: HeaderCollectionViewDelegate {
    func didTapHeaderButton() {
        isEditingMode.toggle()
        presenter.createViewModel()
    }
}

// MARK: - SkillCollectionViewCellDelegate
extension ViewController: SkillCollectionViewCellDelegate {
    func didTapDeleteButton(for title: String) {
        presenter.removeSkill(title)
    }
}

// MARK: - ViewControllerProtocol
extension ViewController: ViewControllerProtocol {
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

