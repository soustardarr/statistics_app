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
        return chart
    }()

    var data: [Statistics]? {
        didSet {
            guard let data = data else { return }
            updateChart(with: data)
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
        var dateCounts: [Date: Int] = [:]
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"

        var allDates: [Date] = []
        for stat in statistics {
            for dateNumber in stat.dates {
                let dateString = String(format: "%08d", dateNumber)
                let day = Int(dateString.prefix(2)) ?? 1
                let month = Int(dateString.dropFirst(2).prefix(2)) ?? 1
                let year = Int(dateString.suffix(4)) ?? 2024
                if month > 12 || month < 1 || day > 31 || day < 1 {
                    continue
                }
                if let date = calendar.date(from: DateComponents(year: year, month: month, day: day)) {
                    allDates.append(date)
                    dateCounts[date, default: 0] += 1
                } else {
                    print("Failed to create date from: day \(day), month \(month), year \(year)")
                }
            }
        }

        // Уникализируем даты и сортируем по возрастанию
        let uniqueDates = Array(Set(allDates)).sorted { $0 < $1 }

        let dateStrings = uniqueDates.map { dateFormatter.string(from: $0) }

        // Создаем данные для графика
        let entries = uniqueDates.compactMap { date -> ChartDataEntry? in
            if let count = dateCounts[date], count > 0 {
                if let index = uniqueDates.firstIndex(of: date) {
                    return ChartDataEntry(x: Double(index), y: Double(count))
                }
            }
            return nil
        }

        // Настройка набора данных
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

        // Настройка осей
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelTextColor = .gray
        chartView.xAxis.labelFont = .systemFont(ofSize: 12)
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dateStrings)
        chartView.xAxis.granularity = 1.0
        chartView.xAxis.labelCount = dateStrings.count

        // Настройка левой оси для горизонтальных линий
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

        // Настройка маркера для пиковой точки
        if let maxEntry = entries.max(by: { $0.y < $1.y }) {
            let marker = BalloonMarker(color: .white, font: .systemFont(ofSize: 12), textColor: .red, insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
            marker.chartView = chartView
            marker.minimumSize = CGSize(width: 128, height: 72)
            chartView.marker = marker
        }

        chartView.animate(xAxisDuration: 1.0)
        chartView.setNeedsDisplay()
    }
}

class BalloonMarker: MarkerView {
    private var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()

    private var _minimumSize: CGSize = CGSize(width: 0, height: 0)

    var minimumSize: CGSize {
        get { _minimumSize }
        set {
            _minimumSize = newValue
            frame.size = _minimumSize
            setNeedsLayout()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }

    convenience init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets) {
        self.init(frame: .zero)
        backgroundColor = color
        label.font = font
        label.textColor = textColor
        self.offset = CGPoint(x: 0, y: -(insets.top + insets.bottom + label.font.lineHeight) / 2)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        let dateIndex = Int(entry.x)
        if let dateStrings = chartView?.xAxis.valueFormatter as? IndexAxisValueFormatter,
           dateIndex >= 0 && dateIndex < dateStrings.values.count {
            let count = Int(entry.y)
            let dateString = dateStrings.stringForValue(Double(dateIndex), axis: chartView?.xAxis ?? chartView?.xAxis)
            label.text = "\(count) посетитель\(count == 1 ? "" : "ов")\n\(dateString)"
            isHidden = false
        } else {
            isHidden = true
        }
        super.refreshContent(entry: entry, highlight: highlight)
    }

    override func draw(context: CGContext, point: CGPoint) {
        guard !isHidden else { return }
        super.draw(context: context, point: point)
    }
}
