//
//  Presenter.swift
//  ProfileApp
//
//  Created by Вадим Кузьмин on 01.08.2023.
//

import Foundation

protocol PresenterProtocol {
    var viewController: ViewControllerProtocol? { get set }
    var skillsViewModel: [SkillCellViewModel] { get }
    func addNewSkill(_ skill: String)
    func removeSkill(_ skill: String)
    func createViewModel()
}

class Presenter: PresenterProtocol {
    // MARK: - Public Properties
    weak var viewController: ViewControllerProtocol?
    private(set) var skillsViewModel: [SkillCellViewModel] = []

    // MARK: - Private Properties
    private var skills = ["MVI/MVVM", "Kotlin Coroutines", "Room", "OkHttp", "DataStore", "WorkManager", "custom view", "DataStore", "ООП и SOLID"]
    private var oldSkillsViewModel: [SkillCellViewModel] = []
    private var insertedIndexes: [IndexPath] = []
    private var removedIndexes: [IndexPath] = []

    // MARK: - Public Methods
    func addNewSkill(_ skill: String) {
        guard checkRepeatingSkill(skill) == false else {
            return
        }
        skills.append(skill)
        createViewModel()
    }

    func removeSkill(_ skill: String) {
        guard let index = skills.firstIndex(of: skill) else {
            return
        }
        skills.remove(at: index)
        createViewModel()
    }

    func createViewModel() {
        guard let viewController else {
            return
        }
        oldSkillsViewModel = skillsViewModel
        skillsViewModel.removeAll()
        let viewWidth: CGFloat = viewController.collectionViewWidth
        var availableWidth = viewWidth

        var count = skills.count - 1
        if viewController.isEditingMode {
            count += 1
        }

        if count < 0 {
            viewController.reloadCollectionView()
            return 
        }

        for index in 0...count {
            var width = calculateWidth(index: index)
            let title = getTitle(index: index)
            let remainingWidth = availableWidth - width
            if remainingWidth > 0 {
                skillsViewModel.append(SkillCellViewModel(title: title, width: width, isTransparent: false))
                availableWidth = availableWidth - width - 12
            } else {
                if availableWidth > 0 {
                    skillsViewModel.append(SkillCellViewModel(title: "", width: availableWidth, isTransparent: true))
                }
                if width > viewWidth {
                    width = viewWidth
                }
                skillsViewModel.append(SkillCellViewModel(title: title, width: width, isTransparent: false))
                availableWidth = viewWidth - width - 12
            }
        }
        viewController.reloadCollectionView()
    }

    // MARK: - Private Methods
    private func calculateWidth(index: Int) -> CGFloat {
        if index == skills.count {
            return 57
        }
        var buttonWidthMultiplier: CGFloat = 2
        if let viewController, viewController.isEditingMode {
            buttonWidthMultiplier = 3
        }
        let string = skills[index]
        return string.width() + 24 * buttonWidthMultiplier
    }

    private func getTitle(index: Int) -> String {
        if index == skills.count  {
            return ""
        }
        return skills[index]
    }

    private func checkRepeatingSkill(_ skill: String) -> Bool {
        if skills.first(where: { $0.lowercased() == skill.lowercased() }) != nil {
            viewController?.showAlert()
            return true
        } else {
            return false
        }
    }
}
