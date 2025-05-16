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
        collectionView.sections = [
            .usersView([
                .init(count: 1321, type: .view)
            ]),
            .dateIntervals([
                .init(isSelected: false, typeView: .onDay),
                .init(isSelected: true, typeView: .onWeek),
                .init(isSelected: false, typeView: .onMonth)
            ]),

            .frequentVisitors(
                [
                    FrequentVisitors(
                        visitors: [
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
                        ]
                    )
                ]
            ),

            .genderIntervals([
                .init(isSelected: true, typeView: .day),
                .init(isSelected: false, typeView: .week),
                .init(isSelected: false, typeView: .month),
                .init(isSelected: false, typeView: .allTime),
            ]),
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
            .bottom(20)

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
