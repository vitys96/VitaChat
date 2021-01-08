//
//  PeopleViewController.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 17.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import RxSwift
import UIKit

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
        collectionView.delegate = self
        collectionView.register(cellType: PeopleCollectionCell.self)
        collectionView.registerView(viewType: SectionHeader.self, elementKind: UICollectionView.elementKindSectionHeader)
        return collectionView
    }()

    private lazy var logOutButton = UIButton().with {
        $0.setImage(UIImage.withName("logOut"), for: .normal)
    }

    // MARK: - Protocol properties
    private let output: PeopleViewOutput

    // MARK: - Properties
    private let colorManager = DIContainer.colorManager
    private let disposeBag = DisposeBag()
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
    private func bindObservable() {
        logOutButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in self.output.didTapLogOutButton() })
            .disposed(by: disposeBag)
    }

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

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logOutButton)
        navigationController?.navigationBar.shadowImage = UIImage()

        collectionView.backgroundColor = backgroundColor
    }

}

// MARK: - PeopleViewInput
extension PeopleViewController: PeopleViewInput {

    func showDataSource(data: NSDiffableDataSourceSnapshot<UsersSection, PeopleViewModel>) {
        dataSource?.apply(data, animatingDifferences: true)
        collectionView.reloadData()
    }

    func reloadData(with searchText: String?) {
//        let peopleViewModel = users.map { PeopleViewModel(with: $0) }
//        let filtered = peopleViewModel.filter { user in
//            return user.containsText(filterText: searchText)
//        }
//        var snapshot = NSDiffableDataSourceSnapshot<UsersSection, PeopleViewModel>()
//
//        snapshot.appendSections([.users])
//
//        snapshot.appendItems(filtered, toSection: .users)
//        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UISearchBarDelegate
extension PeopleViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reloadData(with: searchText)
    }

}

// MARK: - UICollectionViewDelegate
extension PeopleViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let user = dataSource?.itemIdentifier(for: indexPath) else { return }
        output.didSelectUser(user: user)
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
                return cell
            }
        })

        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(with: SectionHeader.self,
                                                                                       elementKind: kind,
                                                                                       for: indexPath)
            guard let section = UsersSection(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
            if let peopleViewModels = self.dataSource?.snapshot().itemIdentifiers(inSection: .users) {
                sectionHeader.setup(title: section.desr(usersCount: peopleViewModels.count))
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
