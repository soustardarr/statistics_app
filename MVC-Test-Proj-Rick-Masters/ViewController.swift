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
            .genderIntervals([
                .init(isSelected: true, typeView: .day),
                .init(isSelected: false, typeView: .week),
                .init(isSelected: false, typeView: .month),
                .init(isSelected: false, typeView: .allTime),
            ])
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
