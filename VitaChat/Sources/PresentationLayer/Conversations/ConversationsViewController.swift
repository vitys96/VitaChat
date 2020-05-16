//
//  ConversationsViewController.swift
//  VitaChat
//
//  Created Okhrimenko Vitaliy on 11.05.2020.
//  Copyright © 2020 Okhrimenko Vitaliy. All rights reserved.
//

import UIKit

enum Section: Int, CaseIterable {
    case  waitingChats, activeChats
}

final class ConversationsViewController: BaseViewController {

    // MARK: - Subviews
    private let searchController = UISearchController(searchResultsController: nil).with {
        $0.hidesNavigationBarDuringPresentation = false
        $0.obscuresBackgroundDuringPresentation = false
    }

    private lazy var collectionView: UICollectionView = {
        let flowLayout = createCompositionalLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.accessibilityIdentifier = "collectionView"
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ActiveChatsCollectionCell.self, forCellWithReuseIdentifier: "cellid")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellid2")
        return collectionView
    }()

    // MARK: - Protocol properties
    private let output: ConversationsViewOutput
    let activeChats = Bundle.main.decode([ConversationModelCell].self, from: "activeChats.json")
    let waitingChats = Bundle.main.decode([ConversationModelCell].self, from: "waitingChats.json")
    var dataSource: UICollectionViewDiffableDataSource<Section, ConversationModelCell>?

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
        reloadData()
        bindObservable()
        output.viewDidLoad()
    }

    // MARK: - Layout
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        layout()
    }

    private func layout() {

        collectionView.pin.all()

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

    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ConversationModelCell>()

        snapshot.appendSections([.waitingChats, .activeChats])

        snapshot.appendItems(waitingChats, toSection: .waitingChats)
        snapshot.appendItems(activeChats, toSection: .activeChats)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }

}

// MARK: - ConversationsViewInput
extension ConversationsViewController: ConversationsViewInput {}

// MARK: - UISearchBarDelegate
extension ConversationsViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
}

// MARK: - Data Source
extension ConversationsViewController {

    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, ConversationModelCell>(collectionView: collectionView,
                                                                                        cellProvider: { (collectionView, indexPath, chat) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }

            switch section {
            case .activeChats:
                let cell = collectionView.cell(at: indexPath, for: ActiveChatsCollectionCell.self)
                cell.setup(with: chat)
                cell.backgroundColor = self.colorManager.n11
                return cell
            case .waitingChats:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid2", for: indexPath)
                cell.backgroundColor = .systemRed
                return cell
            }
        })
    }

}

// MARK: - Setup layout
extension ConversationsViewController {

    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (senctionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in

            guard let section = Section(rawValue: senctionIndex) else {
                fatalError("Unknown section kind")
            }

            switch section {
            case .activeChats:
                return self.createActiveChats()
            case .waitingChats:
                return self.createWaitingChats()
            }
        }
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
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
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
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)

        return section
    }

}
