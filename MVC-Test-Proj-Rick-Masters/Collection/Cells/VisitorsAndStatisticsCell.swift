import UIKit

class VisitorsAndStatisticsCell: UICollectionViewCell {

    var data: VisitorsAndStatistics? {
        didSet {
            updateProgress()
        }
    }

    var dateInterval: DateInterval.TypeView? {
        didSet {
            guard let _ = data else { return }
            updateCircle()
        }
    }

    private var circleView: CircleView?

    private lazy var manStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 6
        stack.addArrangedSubview(manImageView)
        stack.addArrangedSubview(manLabel)
        return stack
    }()

    private lazy var manImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.ellipseMan
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var manLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Мужчины 40%"
        label.font = .systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 500))
        return label
    }()

    private lazy var womanStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 6
        stack.addArrangedSubview(womanImageView)
        stack.addArrangedSubview(womanLabel)
        return stack
    }()

    private lazy var womanImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.ellipseWoman
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var womanLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Женщины 60%"
        label.font = .systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 500))
        return label
    }()

    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var age18To21: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "18-21"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 500))
        return label
    }()

    private lazy var age22To25: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "22-25"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 500))
        return label
    }()

    private lazy var age26To30: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "26-30"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 500))
        return label
    }()

    private lazy var age31To35: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "31-35"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 500))
        return label
    }()

    private lazy var age36To40: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "36-40"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 500))
        return label
    }()

    private lazy var age40To50: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "40-50"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 500))
        return label
    }()

    private lazy var ageAbove50: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ">50"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 500))
        return label
    }()

    private lazy var ageStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.addArrangedSubview(age18To21)
        stack.addArrangedSubview(age22To25)
        stack.addArrangedSubview(age26To30)
        stack.addArrangedSubview(age31To35)
        stack.addArrangedSubview(age36To40)
        stack.addArrangedSubview(age40To50)
        stack.addArrangedSubview(ageAbove50)
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateCircle() {
        circleView?.removeFromSuperview()
        let manWomanPercentage: (man: CGFloat, woman: CGFloat) = VisitorsAndStatisticsDataMapper.getPercentageManWomanOnInterval(dateInterval: dateInterval!, visitorsAndStatistics: data!)

        manLabel.text = "Мужчины \(Int(manWomanPercentage.man * 100))%"
        womanLabel.text = "Женщины \(Int(manWomanPercentage.woman * 100))%"

        circleView = CircleView(frame: CGRect(x: 0, y: 0, width: 142, height: 142), redPercentage: manWomanPercentage.man, orangePercentage: manWomanPercentage.woman)
        circleView?.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(circleView!)

        NSLayoutConstraint.activate([
            circleView!.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            circleView!.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            circleView!.widthAnchor.constraint(equalToConstant: 142),
            circleView!.heightAnchor.constraint(equalToConstant: 142)
        ])
        contentView.layoutIfNeeded()
    }

    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true

        contentView.addSubview(manStackView)
        contentView.addSubview(womanStackView)
        contentView.addSubview(lineView)
        contentView.addSubview(ageStackView)

        NSLayoutConstraint.activate([
            manStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            manStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 190),

            womanStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            womanStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 190),

            womanImageView.widthAnchor.constraint(equalToConstant: 10),
            manImageView.widthAnchor.constraint(equalToConstant: 10),

            lineView.heightAnchor.constraint(equalToConstant: 0.3),
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lineView.topAnchor.constraint(equalTo: manStackView.bottomAnchor, constant: 22),

            ageStackView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 24),
            ageStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            ageStackView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func updateProgress() {
        let ageLabels = [age18To21, age22To25, age26To30, age31To35, age36To40, age40To50, ageAbove50]
        for (_, label) in ageLabels.enumerated() {
            let twoLinesView = TwoLinesView(frame: .zero)

            twoLinesView.data = VisitorsAndStatisticsDataMapper.getPercentageManWomanOnIntervalWithAge(
                dateInterval: dateInterval ?? .day,
                visitorsAndStatistics: data,
                ageRangeLabel: label.text!
            )
            contentView.addSubview(twoLinesView)
            NSLayoutConstraint.activate([
                twoLinesView.widthAnchor.constraint(equalToConstant: 230),
                twoLinesView.heightAnchor.constraint(equalToConstant: 27),
                twoLinesView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 30),
                twoLinesView.topAnchor.constraint(equalTo: label.topAnchor, constant: -7)
            ])
        }

        contentView.layoutIfNeeded()
    }
}
