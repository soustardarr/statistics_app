//
//  ViewController.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 15.05.2025.
//

import UIKit
import PinLayout

class ViewController: UIViewController {

    // MARK: - переменные

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
            Statistics(user_id: 1, type: .view, dates: [5092024,
                                                        17052024,
                                                        17052024,
                                                        17052024,
                                                        17052024,
                                                        18052024,
                                                        19052024,
                                                        20052024,
                                                        21052024,
                                                        22052024,
                                                        10092024,
                                                        10092024,
                                                        10102024,
                                                        11102024,
                                                        11122024,
                                                        11122024,

                                                        11092024]),
            Statistics(user_id: 2, type: .view, dates: [5092024,
                                                        20092024,
                                                        10092024,
                                                        10092024,
                                                        6092024,
                                                        11092024]),
            Statistics(user_id: 3, type: .view, dates: [ 4092024]),
            Statistics(user_id: 4, type: .view, dates: [
                                                        20092024,

                                                        10092024,

                                                        11092024]),
        ]

        let visitors: [Visitor] = [
            Visitor(
                userName: "qpqpqppq",
                id: 3,
                sex: .M,
                age: 12,
                isOnline: false,
                files: [
                    File(
                        id: 3,
                        url: "https://img.freepik.com/free-photo/portrait-young-businesswoman-holding-eyeglasses-hand-against-gray-backdrop_23-2148029483.jpg",
                        type: .avatar
                    )
                ]
            ),
            Visitor(
                userName: "qpqpqppq",
                id: 3,
                sex: .M,
                age: 12,
                isOnline: false,
                files: [
                    File(
                        id: 3,
                        url: "https://img.freepik.com/free-photo/portrait-young-businesswoman-holding-eyeglasses-hand-against-gray-backdrop_23-2148029483.jpg",
                        type: .avatar
                    )
                ]
            ),
            Visitor(
                userName: "GGGGG",
                id: 1,
                sex: .M,
                age: 12,
                isOnline: true,
                files: [
                    File(
                        id: 1,
                        url: "https://img.freepik.com/free-photo/front-view-of-man-with-headphones-in-the-city_23-2148573065.jpg",
                        type: .avatar
                    )
                ]
            ),
            Visitor(
                userName: "GGdasdasd",
                id: 2,
                sex: .F,
                age: 12,
                isOnline: true,
                files: [
                    File(
                        id: 2,
                        url: "https://img.freepik.com/premium-photo/young-woman-smiles-while-walking-in-a-city-street-during-the-day_906809-27175.jpg",
                        type: .avatar
                    )
                ]
            )
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



//let url1 = "http://test.rikmasters.ru/api/statistics/"
//        let url2 = "http://test.rikmasters.ru/api/users/"
//
//        guard let url = URL(string: url1) else { return }
//
//        let urlReq = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: urlReq) { data, response, error in
//            if let error = error {
//                print("Error: \(error)")
//                return
//            }
//            do {
//                guard let data = data else { return }
//                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
//
//                let prettyJsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
//                if let jsonString = String(data: prettyJsonData, encoding: .utf8) {
//                    print("JSON:\n\(jsonString)")
//                } else {
//                }
//            } catch {
//                print("Ошибка обработки JSON: \(error.localizedDescription)")
//            }
//            if let response = response {
//                print("rsponse :\(response)")
//            }
//
//        }.resume()
