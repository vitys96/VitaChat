//
//  ConversationsViewController.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 11.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

final class ConversationsViewController: BaseViewController {

    // MARK: - Subviews
    private let searchController = UISearchController(searchResultsController: nil).with {
        $0.hidesNavigationBarDuringPresentation = false
        $0.obscuresBackgroundDuringPresentation = false
    }

    private lazy var collectionView: UICollectionView = {
        let flowLayout = createCompositionalLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(cellType: ActiveChatsCollectionCell.self)
        collectionView.registerView(viewType: SectionHeader.self, elementKind: UICollectionView.elementKindSectionHeader)
        collectionView.register(cellType: WaitingChatsCollectionCell.self)
        collectionView.delegate = self
        return collectionView
    }()

    // MARK: - Protocol properties
    private let output: ConversationsViewOutput
    var dataSource: UICollectionViewDiffableDataSource<ConversationCellType, ConversationCellViewModel>?

    // MARK: - Properties
    private let colorManager = DIContainer.colorManager

    // MARK: - Init
    init(output: ConversationsViewOutput) {
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
        extendedLayoutIncludesOpaqueBars = true
    }

}

// MARK: - ConversationsViewInput
extension ConversationsViewController: ConversationsViewInput {

    func configureView(navigationTitle: String) {
        navigationItem.title = navigationTitle
    }

    func showDataSource(snapshot: NSDiffableDataSourceSnapshot<ConversationCellType, ConversationCellViewModel>) {
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UISearchBarDelegate
extension ConversationsViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
}

extension ConversationsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let chat = dataSource?.itemIdentifier(for: indexPath),
              let section = ConversationCellType(rawValue: indexPath.section) else {
            return
        }
        switch section {
        case .waitingChats:
            output.didTapWaitingChat(with: chat)
        case .activeChats:
            output.didTapActiveChat(with: chat)
        }
    }

}

// MARK: - Data Source
extension ConversationsViewController {

    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ConversationCellType,
                                                        ConversationCellViewModel>(collectionView: collectionView,
                                                                                        cellProvider: { (collectionView, indexPath, chat) -> UICollectionViewCell? in
            guard let section = ConversationCellType(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }

            switch section {
            case .activeChats:
                let cell = collectionView.cell(at: indexPath, for: ActiveChatsCollectionCell.self)
                cell.setup(with: chat)
                cell.backgroundColor = self.colorManager.n11
                return cell
            case .waitingChats:
                let cell = collectionView.cell(at: indexPath, for: WaitingChatsCollectionCell.self)
                cell.setup(with: chat)
                return cell
            }
        })

        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(with: SectionHeader.self,
                                                                                       elementKind: kind,
                                                                                       for: indexPath)
            guard let section = ConversationCellType(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
            sectionHeader.setup(title: section.description)
            
            return sectionHeader
        }
    }

}

// MARK: - Setup layout
extension ConversationsViewController {

    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (senctionIndex, _) -> NSCollectionLayoutSection? in

            guard let section = ConversationCellType(rawValue: senctionIndex) else {
                fatalError("Unknown section kind")
            }

            switch section {
            case .activeChats:
                return self.createActiveChats()
            case .waitingChats:
                return self.createWaitingChats()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }

    private func createWaitingChats() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(88),
                                               heightDimension: .absolute(88))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20

        let sectionHeader = collectionView.createSectionHeader(width: .fractionalWidth(1), height: .estimated(100))
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 10, bottom: 0, trailing: 10)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .continuous

        return section
    }

    private func createActiveChats() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(78))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8

        let sectionHeader = collectionView.createSectionHeader(width: .fractionalWidth(1), height: .estimated(1))
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 10, bottom: 0, trailing: 10)
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }

}
