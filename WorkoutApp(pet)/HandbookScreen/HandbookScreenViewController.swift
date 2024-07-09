//
//  HomeScreenViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 05.02.2024.
//

//import UIKit

//final class HandbookScreenViewController: UIViewController {
//    //MARK: - Variables
//    private let router: Router
//    private let viewModel: HandbookViewModel
//    
//    private let tableView = UITableView()
//    private let activityIndicator = CustomActivityIndicator(frame: CGRect(), text: Const.loading)
//    
//    //MARK: - Lifecycle
//    init(viewModel: HandbookViewModel, router: Router) {
//        self.viewModel = viewModel
//        self.router = router
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableViewSettings()
//        navigationBarAppearance()
//        setupUI()
//        setupLayout()
//        activityIndicator.startAnimating()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.isNavigationBarHidden = false
//        tabBarController?.tabBar.isHidden = false
//    }
//}
//
//    //MARK: - UI setup and layout
//private extension HandbookScreenViewController {
//    
//    func setupUI() {
//        tableView.backgroundColor = ColorResources.black
//        view.setupView(tableView)
//        tableView.setupView(activityIndicator)
//    }
//    
//    func setupLayout() {
//        NSLayoutConstraint.activate([
//            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//    }
//    
//    func navigationBarAppearance() {
//        navigationItem.title = Const.handbook
//        navigationController?.isNavigationBarHidden = false
//        tabBarController?.tabBar.backgroundColor = ColorResources.customDarkGrey
//        
//        let appearance = UINavigationBarAppearance()
//        appearance.titleTextAttributes = [
//            .font: FontResources.navigationTitleFont,
//            .foregroundColor: ColorResources.white
//        ]
//        
//        navigationController?.navigationBar.standardAppearance = appearance
//    }
//    
//    func tableViewSettings() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(HandbookCell.self, forCellReuseIdentifier: HandbookCell.identifier)
//
//        viewModel.handbookExerciseUpdated = { [weak self] in
//            DispatchQueue.main.async {
//                self?.tableView.reloadData()
//            }
//        }
//    }
//}
//
//extension HandbookScreenViewController: UITableViewDataSource, UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.allExercises.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: HandbookCell.identifier, for: indexPath) as? HandbookCell else { fatalError("Unable to dequeue CoinCell in HomeController") }
//        let exercise = viewModel.allExercises[indexPath.row]
//        cell.configure(with: exercise)
//        activityIndicator.stopAnimating()
//        cell.backgroundColor = .clear
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        80
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let exercise = viewModel.allExercises[indexPath.row]
//        
//        let viewModel = ExerciseInfoViewModel(exercise)
//        let viewController = ExerciseInfoController(viewModel)
//        present(viewController, animated: true, completion: nil)
//    }
//    
//    
//}

import UIKit
import Charts
import DGCharts

class StepCounterViewController: UIViewController {

    private var barChartView: BarChartView!
    private var viewModel: StepCounterViewModel
    private let router: Router

    init(viewModel: StepCounterViewModel, router: Router) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = StepCounterViewModel()
        viewModel.onUpdate = { [weak self] in
            self?.updateChart()
        }

        setupBarChartView()
        viewModel.startStepCounting()
    }

    func setupBarChartView() {
        barChartView = BarChartView()
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(barChartView)

        // Установка ограничений для barChartView
        NSLayoutConstraint.activate([
            barChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            barChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            barChartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            barChartView.heightAnchor.constraint(equalToConstant: 300)
        ])

        // Настройка оси X для отображения чисел и месяцев
        let xAxis = barChartView.xAxis
        xAxis.valueFormatter = DateAxisValueFormatter()
        xAxis.granularity = 1
        xAxis.labelPosition = .bottom

        // Настройка оси Y для отображения целых чисел и включения горизонтальной сетки
        let leftAxis = barChartView.leftAxis
        leftAxis.valueFormatter = DefaultAxisValueFormatter { (value, axis) in
            return "\(Int(value))"
        }
        leftAxis.drawGridLinesEnabled = true // Включение горизонтальной сетки на левой оси

        let rightAxis = barChartView.rightAxis
        rightAxis.valueFormatter = DefaultAxisValueFormatter { (value, axis) in
            return "\(Int(value))"
        }
        rightAxis.drawGridLinesEnabled = true // Включение горизонтальной сетки на правой оси

        // Включение горизонтальной прокрутки
        barChartView.dragEnabled = true
        barChartView.setScaleEnabled(true)
        barChartView.pinchZoomEnabled = false
        barChartView.drawGridBackgroundEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false // Отключение вертикальной сетки
    }

    func updateChart() {
        var entries: [BarChartDataEntry] = []

        let calendar = Calendar.current
        let now = Date()
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now)) else {
            return
        }
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!

        // Фильтрация данных только для текущей недели
        let currentWeekData = viewModel.stepCountData.filter { $0.date >= startOfWeek && $0.date <= endOfWeek }

        for (index, data) in currentWeekData.enumerated() {
            let entry = BarChartDataEntry(x: Double(index), y: Double(data.steps))
            entries.append(entry)
        }

        let dataSet = BarChartDataSet(entries: entries, label: "Шаги")
        dataSet.colors = [UIColor.blue]
        dataSet.valueFormatter = IntegerValueFormatter() // Форматирование значений как целых чисел

        let data = BarChartData(dataSet: dataSet)
        barChartView.data = data
        barChartView.notifyDataSetChanged()
    }
}

class DateAxisValueFormatter: AxisValueFormatter {

    let dateFormatter: DateFormatter

    init() {
        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU") // Установите нужную локаль для вывода дат на нужном языке
        dateFormatter.dateFormat = "d MMM" // Формат вывода даты
    }

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSince1970: value * 86400.0) // Преобразование числа в дату
        return dateFormatter.string(from: date)
    }
}

class IntegerValueFormatter: ValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return String(format: "%.0f", value)
    }
}
