//
//  ChartVisitorsCell.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 16.05.2025.
//
import UIKit
import DGCharts

class ChartVisitorsCell: UICollectionViewCell {

    private lazy var chartView: LineChartView = {
        let chart = LineChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.backgroundColor = .clear
        chart.isUserInteractionEnabled = true
        chart.doubleTapToZoomEnabled = true
        chart.pinchZoomEnabled = true
        chart.dragEnabled = true
        return chart
    }()

    var data: [Statistics]? {
        didSet {
            guard let data = data else { return }
            updateChart(with: data)
        }
    }

    var dateInterval: DateInterval.TypeView? {
        didSet {
            if let data = data {
                updateChart(with: data)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(chartView)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 14
        contentView.clipsToBounds = true

        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            chartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            chartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            chartView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            chartView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func updateChart(with statistics: [Statistics]) {
        guard let typeView = dateInterval else { return }

        var dateCounts: [String: Int] = [:]
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()

        var allKeys: [String] = []
        var displayLabels: [String] = []

        for stat in statistics {
            for dateNumber in stat.dates {
                let dateString = String(format: "%08d", dateNumber)
                let day = Int(dateString.prefix(2)) ?? 1
                let month = Int(dateString.dropFirst(2).prefix(2)) ?? 1
                let year = Int(dateString.suffix(4)) ?? 2024

                if month > 12 || month < 1 || day > 31 || day < 1 {
                    continue
                }

                guard let date = calendar.date(from: DateComponents(year: year, month: month, day: day)) else {
                    print("Failed to create date")
                    continue
                }

                var key: String
                var label: String

                switch typeView {
                case .onDay:
                    dateFormatter.dateFormat = "dd.MM.yyyy"
                    key = dateFormatter.string(from: date)
                    dateFormatter.dateFormat = "dd.MM"
                    label = dateFormatter.string(from: date)

                case .onWeek:
                    let components = calendar.dateComponents([.year, .weekOfYear], from: date)
                    guard let year = components.year, let week = components.weekOfYear else { continue }
                    key = "\(year)-\(week)"
                    if let weekStart = calendar.date(from: calendar.dateComponents([.year, .weekOfYear], from: date)) {
                        dateFormatter.dateFormat = "dd.MM"
                        label = "Week \(week)"
                    } else {
                        label = "Week \(week)"
                    }

                case .onMonth:
                    dateFormatter.dateFormat = "MM.yyyy"
                    key = dateFormatter.string(from: date)
                    dateFormatter.dateFormat = "MMM yyyy"
                    label = dateFormatter.string(from: date)
                default:
                    dateFormatter.dateFormat = "MM.yyyy"
                    key = dateFormatter.string(from: date)
                    dateFormatter.dateFormat = "MMM yyyy"
                    label = dateFormatter.string(from: date)
                }

                dateCounts[key, default: 0] += 1
                if !allKeys.contains(key) {
                    allKeys.append(key)
                    displayLabels.append(label)
                }
            }
        }

        let sortedDates = allKeys.enumerated().sorted { (a, b) -> Bool in
            let dateA = parseDate(from: a.element, typeView: typeView, calendar: calendar)
            let dateB = parseDate(from: b.element, typeView: typeView, calendar: calendar)
            return dateA < dateB
        }

        let sortedKeys = sortedDates.map { $0.element }
        let sortedLabels = sortedDates.map { displayLabels[$0.offset] }

        let entries = sortedKeys.enumerated().compactMap { (index, key) -> ChartDataEntry? in
            if let count = dateCounts[key], count > 0 {
                return ChartDataEntry(x: Double(index), y: Double(count))
            }
            return nil
        }

        let set = LineChartDataSet(entries: entries, label: "Посетители")
        set.colors = [NSUIColor.red]
        set.circleColors = [NSUIColor.red]
        set.circleRadius = 4
        set.lineWidth = 2
        set.mode = .linear
        set.drawValuesEnabled = false
        set.drawCirclesEnabled = true
        set.drawCircleHoleEnabled = false

        let data = LineChartData(dataSet: set)
        chartView.data = data

        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelTextColor = .gray
        chartView.xAxis.labelFont = .systemFont(ofSize: 12)
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: sortedLabels)
        chartView.xAxis.granularity = 1.0
        chartView.xAxis.axisMinimum = -0.5
        chartView.xAxis.axisMaximum = Double(sortedLabels.count - 1) + 0.5
        chartView.xAxis.labelCount = sortedLabels.count

        chartView.leftAxis.enabled = true
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = true
        chartView.leftAxis.gridColor = .lightGray
        chartView.leftAxis.gridLineDashLengths = [5, 5]
        chartView.leftAxis.labelCount = 3
        chartView.leftAxis.forceLabelsEnabled = true
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.axisMaximum = Double(entries.map { $0.y }.max() ?? 1) * 1.2
        chartView.leftAxis.granularity = 1.0

        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false

        if let maxEntry = entries.max(by: { $0.y < $1.y }) {
            let marker = CustomMarkerView(frame: .zero)
            marker.chartView = chartView
            chartView.marker = marker
        }

        chartView.animate(xAxisDuration: 1.0)
        chartView.setNeedsDisplay()
    }

    private func parseDate(from key: String, typeView: DateInterval.TypeView, calendar: Calendar) -> Date {
        let dateFormatter = DateFormatter()
        switch typeView {
        case .onDay:
            dateFormatter.dateFormat = "dd.MM.yyyy"
            return dateFormatter.date(from: key) ?? Date.distantPast
        case .onWeek:
            let parts = key.split(separator: "-")
            guard parts.count == 2,
                  let year = Int(parts[0]),
                  let week = Int(parts[1]) else { return Date.distantPast }
            let components = DateComponents(year: year, weekOfYear: week)
            return calendar.date(from: components) ?? Date.distantPast
        case .onMonth:
            dateFormatter.dateFormat = "MM.yyyy"
            return dateFormatter.date(from: key) ?? Date.distantPast
        default:
            dateFormatter.dateFormat = "MM.yyyy"
            return dateFormatter.date(from: key) ?? Date.distantPast
        }
    }
}

class CustomMarkerView: MarkerView {

    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }

    private func setupLabel() {
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.numberOfLines = 0
        addSubview(label)
    }

    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        let count = Int(entry.y)
        label.text = "\(count) посещений"
        label.sizeToFit()
        label.frame = CGRect(origin: .zero, size: CGSize(width: label.frame.width + 16, height: label.frame.height + 8))
        frame = label.frame
        offset = CGPoint(x: -(frame.width / 2), y: -frame.height - 10)
    }

    override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint {
        return offset
    }
}
