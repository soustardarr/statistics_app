//
//  ViewController.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 15.05.2025.
//

import UIKit
import PinLayout

class ViewController: UIViewController {

    var model: Model!

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Статистика"
        label.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight(rawValue: 700))
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var collectionView = CollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        let statistics: [Statistics] = [
            Statistics(user_id: 1, type: .view, dates: [
                15052023,
                1012024,
                17052024,
                18052025,
                19052024
            ]),
            Statistics(user_id: 2, type: .view, dates: [
                5092024,
                20092024,
                11092024
            ]),
            Statistics(user_id: 3, type: .view, dates: [
                1052025
            ]),
            Statistics(user_id: 4, type: .view, dates: [
                20092024,
                10092024,
                18052025
            ]),
            Statistics(user_id: 5, type: .view, dates: [
                12052025,
                15052025,
                18052025
            ]),
            Statistics(user_id: 6, type: .view, dates: [
                1052025,
                5052025,
                8052025
            ]),
            Statistics(user_id: 7, type: .view, dates: [
                1012025,
                15052025,
                18052025
            ]),
            Statistics(user_id: 8, type: .view, dates: [
                31012023,
                15032024,
                20092024
            ]),
            Statistics(user_id: 9, type: .view, dates: [
                1052025,
                2052025,
                3052025,
                18052025
            ]),
            Statistics(user_id: 10, type: .view, dates: [
                1012025,
                15032025,
                20042025
            ]),
            Statistics(user_id: 11, type: .view, dates: [
                1012023,
                15032023
            ]),
            Statistics(user_id: 12, type: .view, dates: [
                13052025,
                16052025,
                18052025
            ]),
            Statistics(user_id: 13, type: .view, dates: [
                18052025
            ]),
            Statistics(user_id: 14, type: .view, dates: [
                20092024,
                11092024
            ]),
            Statistics(user_id: 15, type: .view, dates: [
                15052025,
                17052025,
                18052025
            ]),
            Statistics(user_id: 16, type: .view, dates: [
                4092024,
                10092024,
                18052025
            ]),
            Statistics(user_id: 17, type: .view, dates: [
                1052025,
                18052025
            ]),
            Statistics(user_id: 18, type: .view, dates: [
                31012024,
                18052025
            ]),
            Statistics(user_id: 19, type: .view, dates: [
                15052025,
                18052025
            ]),
            Statistics(user_id: 20, type: .view, dates: [
                1052025,
                16052025,
                18052025
            ]),
            Statistics(user_id: 21, type: .view, dates: [
                20092024,
                18052025
            ])
        ]

        let visitors: [Visitor] = [
            Visitor(userName: "AlexM18", id: 1, sex: .M, age: 18, isOnline: true, files: [
                File(id: 1, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "SaraF19", id: 2, sex: .F, age: 19, isOnline: false, files: [
                File(id: 2, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "JohnM21", id: 3, sex: .M, age: 21, isOnline: true, files: [
                File(id: 3, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "EmmaF22", id: 4, sex: .F, age: 22, isOnline: false, files: [
                File(id: 4, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "MikeM24", id: 5, sex: .M, age: 24, isOnline: true, files: [
                File(id: 5, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "LisaF25", id: 6, sex: .F, age: 25, isOnline: false, files: [
                File(id: 6, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "TomM26", id: 7, sex: .M, age: 26, isOnline: true, files: [
                File(id: 7, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "AnnaF28", id: 8, sex: .F, age: 28, isOnline: false, files: [
                File(id: 8, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "PaulM30", id: 9, sex: .M, age: 30, isOnline: true, files: [
                File(id: 9, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "KateF31", id: 10, sex: .F, age: 31, isOnline: false, files: [
                File(id: 10, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "MarkM33", id: 11, sex: .M, age: 33, isOnline: true, files: [
                File(id: 11, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "JuliaF35", id: 12, sex: .F, age: 35, isOnline: false, files: [
                File(id: 12, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "DavidM36", id: 13, sex: .M, age: 36, isOnline: true, files: [
                File(id: 13, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "SophieF38", id: 14, sex: .F, age: 38, isOnline: false, files: [
                File(id: 14, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "PeterM40", id: 15, sex: .M, age: 40, isOnline: true, files: [
                File(id: 15, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "HelenF42", id: 16, sex: .F, age: 42, isOnline: false, files: [
                File(id: 16, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "RobertM45", id: 17, sex: .M, age: 45, isOnline: true, files: [
                File(id: 17, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "MaryF50", id: 18, sex: .F, age: 50, isOnline: false, files: [
                File(id: 18, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "GeorgeM55", id: 19, sex: .M, age: 55, isOnline: true, files: [
                File(id: 19, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "EllenF60", id: 20, sex: .F, age: 60, isOnline: false, files: [
                File(id: 20, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ]),
            Visitor(userName: "HenryM65", id: 21, sex: .M, age: 65, isOnline: true, files: [
                File(id: 21, url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg", type: .avatar)
            ])
        ]

        collectionView.sections = [
            .usersView([
                .init(count: 1321, type: .view)
            ]),
            .dateIntervals([
                .init(isSelected: true, typeView: .onDay),
                .init(isSelected: false, typeView: .onWeek),
                .init(isSelected: false, typeView: .onMonth)
            ]),

            .chartVisitorsCell([
                ArrayStatistics(statistics: statistics)
            ]),

            .frequentVisitors(
                [
                    FrequentVisitors(
                        visitors: visitors
                    )
                ]
            ),

            .genderIntervals([
                .init(isSelected: true, typeView: .day),
                .init(isSelected: false, typeView: .week),
                .init(isSelected: false, typeView: .month),
                .init(isSelected: false, typeView: .allTime),
            ]),

            .visitorsAndStatisticsCell([VisitorsAndStatistics(visitors: visitors, statistics: statistics)]),

            .usersSub([
                .init(
                    usersSub: UsersView(
                        count: 10, type: .subscription
                    ),
                    usersUn: UsersView(
                        count: 21, type: .unsubscription
                    )
                )
            ]),
        ]

        collectionView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }

    private func setupUI() {
        view.backgroundColor = .systemGray6
        addSubviews()
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
}
