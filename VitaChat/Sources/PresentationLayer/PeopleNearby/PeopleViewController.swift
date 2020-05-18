//
//  PeopleViewController.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 17.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

enum UsersSection: Int, CaseIterable {
    case users
    func desr(usersCount: Int) -> String {
        switch self {
        case .users:
            return "Рядом с вами \(usersCount) человек"
        }
    }
}

final class PeopleViewController: BaseViewController {

    // MARK: - Subviews
    private let searchController = UISearchController(searchResultsController: nil).with {
        $0.hidesNavigationBarDuringPresentation = false
        $0.obscuresBackgroundDuringPresentation = false
    }

    private lazy var collectionView: UICollectionView = {
        let flowLayout = createCompositionalLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(cellType: PeopleCollectionCell.self)
        collectionView.registerView(viewType: SectionHeader.self, elementKind: UICollectionView.elementKindSectionHeader)
        return collectionView
    }()

    // MARK: - Protocol properties
    private let output: PeopleViewOutput

    // MARK: - Properties
    private let colorManager = DIContainer.colorManager
    var dataSource: UICollectionViewDiffableDataSource<UsersSection, PeopleViewModel>?

    // MARK: - Init
    init(output: PeopleViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Binding
    private func bindObservable() {}

    // MARK: Life cycle
    override func loadView() {
        view = UIView()
        addSubviews()
    }

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        createDataSource()
        bindObservable()
        output.viewDidLoad()
    }

    // MARK: - Layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        layout()
    }

    private func layout() {
        collectionView.pin
            .top(view.pin.safeArea.top)
            .horizontally()
            .bottom(view.pin.safeArea.bottom)
    }

    // MARK: - Private methods
    private func addSubviews() {

        view.addSubviews([
            collectionView,
        ])

        setupActivityIndicator()
    }

    private func configure() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self

        collectionView.backgroundColor = backgroundColor
    }

}

// MARK: - PeopleViewInput
extension PeopleViewController: PeopleViewInput {

    func showDataSource(data: NSDiffableDataSourceSnapshot<UsersSection, PeopleViewModel>) {
        dataSource?.apply(data, animatingDifferences: true)
    }
}

// MARK: - UISearchBarDelegate
extension PeopleViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
}

// MARK: - Data Source
extension PeopleViewController {

    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<UsersSection, PeopleViewModel>(collectionView: collectionView,
                                                                                        cellProvider: { (collectionView, indexPath, user) -> UICollectionViewCell? in
            guard let section = UsersSection(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }

            switch section {
            case .users:
                let cell = collectionView.cell(at: indexPath, for: PeopleCollectionCell.self)
                cell.setup(with: user)
                cell.backgroundColor = self.colorManager.n11
                return cell
            }
        })

        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(with: SectionHeader.self,
                                                                                       elementKind: kind,
                                                                                       for: indexPath)
            guard let section = UsersSection(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
            if let lal = self.dataSource?.snapshot().itemIdentifiers(inSection: .users) {
                sectionHeader.setup(title: section.desr(usersCount: lal.count))
            }

            return sectionHeader
        }
    }

}

// MARK: - Setup layout
extension PeopleViewController {

    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (senctionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in

            guard let section = UsersSection(rawValue: senctionIndex) else {
                fatalError("Unknown section kind")
            }

            switch section {
            case .users:
                return self.createUsersSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }

    private func createUsersSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(15)
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing

        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 10, bottom: 0, trailing: 10)
        let sectionHeader = collectionView.createSectionHeader(width: .fractionalWidth(1), height: .estimated(1))

        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }

}