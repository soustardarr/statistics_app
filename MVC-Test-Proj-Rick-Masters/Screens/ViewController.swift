//
//  ViewController.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 15.05.2025.
//

import UIKit
import PinLayout
import BusinessLogicFramework
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    var model: Model!
    private let disposeBag = DisposeBag()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Статистика"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var collectionView = CollectionView()
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }

    private func setupUI() {
        view.backgroundColor = .systemGray6
        addSubviews()
        collectionView.refreshControl = refreshControl
    }

    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }

    private func setupLayout() {
        titleLabel.pin
            .top(view.safeAreaInsets.top + 12)
            .horizontally(16)
            .sizeToFit()

        collectionView.pin
            .below(of: titleLabel)
            .marginTop(20)
            .horizontally()
            .bottom()
    }

    private func bindData() {
        model.loadData(dateInterval: .onDay)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                let uiData = data.toUIModel()
                self?.updateCollectionView(with: uiData)
            }, onError: { error in
                print("Error loading data: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }

    @objc private func refreshData() {
        model.refreshData()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                let uiData = data.toUIModel()
                self?.updateCollectionView(with: uiData)
                self?.refreshControl.endRefreshing()
            }, onError: { [weak self] error in
                print("Error refreshing data: \(error.localizedDescription)")
                self?.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }

    private func updateCollectionView(with data: VisitorsAndStatistics) {
        let statistics = data.statistics
        let visitors = data.visitors

        collectionView.sections = [
            .usersView([
                .init(count: statistics.filter { $0.type == .view }.count, type: .view)
            ]),
            .dateIntervals([
                .init(isSelected: true, typeView: .onDay),
                .init(isSelected: false, typeView: .onWeek),
                .init(isSelected: false, typeView: .onMonth)
            ]),
            .chartVisitorsCell([
                ArrayStatistics(statistics: statistics)
            ]),
            .frequentVisitors([
                FrequentVisitors(visitors: visitors)
            ]),
            .genderIntervals([
                .init(isSelected: true, typeView: .day),
                .init(isSelected: false, typeView: .week),
                .init(isSelected: false, typeView: .month),
                .init(isSelected: false, typeView: .allTime),
            ]),
            .visitorsAndStatisticsCell([data]),
            .usersSub([
                .init(
                    usersSub: UsersView(count: statistics.filter { $0.type == .subscription }.count, type: .subscription),
                    usersUn: UsersView(count: statistics.filter { $0.type == .unsubscription }.count, type: .unsubscription)
                )
            ]),
        ]
        collectionView.reloadData()
    }
}
