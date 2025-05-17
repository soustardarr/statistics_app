//
//  CollectionView.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 15.05.2025.
//

import UIKit

class CollectionView: UICollectionView {

    // MARK: - переменные
    var sections: [Sections] = []

    // MARK: - конструкторы

    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        self.collectionViewLayout = createCompositionalLayout()
        setupAppearance()
        dataSource = self
        delegate = self
        registerCells()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupAppearance() {
        backgroundColor = .clear
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        showsVerticalScrollIndicator = false
    }

    private func registerCells() {
        register(HeaderCollectionCell.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: HeaderCollectionCell.reuseIdentifier)
        register(ViewUsersCell.self, forCellWithReuseIdentifier: ViewUsersCell.reuseIdentifier)
        register(IntervalCell.self, forCellWithReuseIdentifier: IntervalCell.reuseIdentifier)
        register(SubUsersCell.self, forCellWithReuseIdentifier: SubUsersCell.reuseIdentifier)
        register(FrequentVisitorsCell.self, forCellWithReuseIdentifier: FrequentVisitorsCell.reuseIdentifier)
        register(ChartVisitorsCell.self, forCellWithReuseIdentifier: ChartVisitorsCell.reuseIdentifier)
        register(VisitorsAndStatisticsCell.self, forCellWithReuseIdentifier: VisitorsAndStatisticsCell.reuseIdentifier)
    }

    private func createLayoutSection(
        group: NSCollectionLayoutGroup,
        behaviour: UICollectionLayoutSectionOrthogonalScrollingBehavior,
        interGroupSpacing: CGFloat,
        hasHeader: Bool,
        contentInsets: NSDirectionalEdgeInsets) -> NSCollectionLayoutSection {
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = behaviour
            section.interGroupSpacing = interGroupSpacing
            section.contentInsets = contentInsets
            if hasHeader {
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(44)
                )
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                section.boundarySupplementaryItems = [header]
            }
            return section
        }


    // MARK: - методы и функции
    private func calculateLayoutSize(width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension) -> NSCollectionLayoutSize {
        return NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
    }

    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            let section = self.sections[sectionIndex]
            switch section {
            case .usersView:
                return self.usersViewLayoutSection()

            case .dateIntervals:
                return self.intervalsLayoutSection()

            case .genderIntervals:
                return self.gendersIntervalsLayoutSection()

            case .usersSub:
                return self.usersSubLayoutSection()
            case .frequentVisitors:
                return self.frequentVisitorsLayoutSection()
            case .chartVisitorsCell:
                return self.statisticsLayoutSection()
            case .visitorsAndStatisticsCell:
                return self.visitorsAndStatisticsLayoutSection()
            }
        }
    }

    private func visitorsAndStatisticsLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = calculateLayoutSize(width: .fractionalWidth(1), height: .estimated(529))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let groupSize = calculateLayoutSize(width: .fractionalWidth(1), height: .estimated(529))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = createLayoutSection(
            group: group,
            behaviour: .none,
            interGroupSpacing: 0,
            hasHeader: false,
            contentInsets: .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        )
        return section
    }


    private func statisticsLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = calculateLayoutSize(width: .fractionalWidth(1), height: .estimated(208))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let groupSize = calculateLayoutSize(width: .fractionalWidth(1), height: .estimated(208))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = createLayoutSection(
            group: group,
            behaviour: .none,
            interGroupSpacing: 0,
            hasHeader: false,
            contentInsets: .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        )
        return section
    }

    private func usersViewLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = calculateLayoutSize(width: .fractionalWidth(1), height: .absolute(98))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let groupSize = calculateLayoutSize(width: .fractionalWidth(1), height: .estimated(98))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = createLayoutSection(
            group: group,
            behaviour: .none,
            interGroupSpacing: 0,
            hasHeader: true,
            contentInsets: .init(top: 12, leading: 16, bottom: 0, trailing: 16)
        )
        return section
    }

    private func usersSubLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = calculateLayoutSize(width: .fractionalWidth(1), height: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let groupSize = calculateLayoutSize(width: .fractionalWidth(1), height: .estimated(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = createLayoutSection(
            group: group,
            behaviour: .none,
            interGroupSpacing: 0,
            hasHeader: true,
            contentInsets: .init(top: 12, leading: 16, bottom: 0, trailing: 16)
        )
        return section
    }

    private func frequentVisitorsLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = calculateLayoutSize(width: .fractionalWidth(1), height: .estimated(186))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let groupSize = calculateLayoutSize(width: .fractionalWidth(1), height: .estimated(186))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = createLayoutSection(
            group: group,
            behaviour: .none,
            interGroupSpacing: 0,
            hasHeader: true,
            contentInsets: .init(top: 12, leading: 16, bottom: 0, trailing: 16)
        )
        return section
    }


    private func intervalsLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = calculateLayoutSize(width: .estimated(120), height: .absolute(32))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let groupSize = calculateLayoutSize(width: .estimated(120), height: .absolute(32))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = createLayoutSection(
            group: group,
            behaviour: .continuous,
            interGroupSpacing: 8,
            hasHeader: false,
            contentInsets: .init(top: 28, leading: 16, bottom: 12, trailing: 16)
        )
        return section
    }

    private func gendersIntervalsLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = calculateLayoutSize(width: .estimated(120), height: .absolute(32))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let groupSize = calculateLayoutSize(width: .estimated(120), height: .absolute(32))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = createLayoutSection(
            group: group,
            behaviour: .continuous,
            interGroupSpacing: 8,
            hasHeader: true,
            contentInsets: .init(top: 12, leading: 16, bottom: 12, trailing: 16)
        )
        return section
    }
}

extension CollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .usersView(let data):
            return data.count
        case .dateIntervals(let data):
            return data.count
        case .genderIntervals(let data):
            return data.count
        case .usersSub(let data):
            return data.count
        case .frequentVisitors(let data):
            return data.count
        case .chartVisitorsCell(let data):
            return data.count
        case .visitorsAndStatisticsCell(let data):
            return data.count
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .usersView(let data):
            let cell: ViewUsersCell = self.dequeueReusableCell(withReuseIdentifier: ViewUsersCell.reuseIdentifier, for: indexPath)  as! ViewUsersCell
            cell.data = ViewUsersCell.Data(count: data[indexPath.row].count, type: data[indexPath.row].type)
            return cell

        case .dateIntervals(let data), .genderIntervals(let data):
            let cell: IntervalCell = self.dequeueReusableCell(withReuseIdentifier: IntervalCell.reuseIdentifier, for: indexPath)  as! IntervalCell
            cell.data = data[indexPath.row]
            return cell

        case .usersSub(let data):
            let cell: SubUsersCell = self.dequeueReusableCell(withReuseIdentifier: SubUsersCell.reuseIdentifier, for: indexPath)  as! SubUsersCell
            cell.data = data[indexPath.row]
            return cell

        case .frequentVisitors(let data):
            let cell: FrequentVisitorsCell = self.dequeueReusableCell(withReuseIdentifier: FrequentVisitorsCell.reuseIdentifier, for: indexPath)  as! FrequentVisitorsCell
            cell.data = data[indexPath.row]
            return cell
        case .chartVisitorsCell(let data):
            let cell: ChartVisitorsCell = self.dequeueReusableCell(withReuseIdentifier: ChartVisitorsCell.reuseIdentifier, for: indexPath)  as! ChartVisitorsCell
            cell.data = data[indexPath.row].statistics
            cell.dateInterval = .onDay
            return cell
        case .visitorsAndStatisticsCell(let data):
            let cell: VisitorsAndStatisticsCell = self.dequeueReusableCell(withReuseIdentifier: VisitorsAndStatisticsCell.reuseIdentifier, for: indexPath)  as! VisitorsAndStatisticsCell
            cell.data = data[indexPath.row]
            cell.dateInterval = .day
            return cell
        }
    }
}

extension CollectionView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case .dateIntervals(var data):
            for i in data.indices {
                data[i].isSelected = (i == indexPath.row)
            }
            sections[indexPath.section] = .dateIntervals(data)
            reloadSections(IndexSet(integer: indexPath.section))


            let typeView = data[indexPath.row].typeView

            if let chartSectionIndex = sections.firstIndex(where: {
                if case .chartVisitorsCell = $0 { return true }
                return false
            }) {
                let chartIndexPath = IndexPath(item: 0, section: chartSectionIndex)
                if let chartCell = collectionView.cellForItem(at: chartIndexPath) as? ChartVisitorsCell {
                    chartCell.dateInterval = typeView
                }
            }

        case .genderIntervals(var data):
            for i in data.indices {
                data[i].isSelected = (i == indexPath.row)
            }
            sections[indexPath.section] = .genderIntervals(data)
            reloadSections(IndexSet(integer: indexPath.section))

            let typeView = data[indexPath.row].typeView

            if let visitorsStatsSectionIndex = sections.firstIndex(where: {
                if case .visitorsAndStatisticsCell = $0 { return true }
                return false
            }) {
                let visitorsStatsIndexPath = IndexPath(item: 0, section: visitorsStatsSectionIndex)
                if let visitorsStatsCell = collectionView.cellForItem(at: visitorsStatsIndexPath) as? VisitorsAndStatisticsCell {
                    visitorsStatsCell.dateInterval = typeView
                }
            }

        default:
            break
        }
    }
}

extension CollectionView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }

        let header = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderCollectionCell.reuseIdentifier,
            for: indexPath
        ) as! HeaderCollectionCell

        switch sections[indexPath.section] {
        case .usersView:
            header.title = "Посетители"
        case .dateIntervals:
            break
        case .usersSub:
            header.title = "Наблюдатели"
        case .genderIntervals:
            header.title = "Пол и возраст"
        case .frequentVisitors:
            header.title = "Чаще всех посещают Ваш профиль"
        case .chartVisitorsCell:
            break
        case .visitorsAndStatisticsCell(_):
            break
        }

        return header
    }
}
