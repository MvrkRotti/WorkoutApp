//
//  WeekChartView.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 04.08.2024.
//

import UIKit
import Charts
import DGCharts

final class WeekChartView: UIView {
    private var barChartView: BarChartView = {
        let chartView = BarChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        return chartView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupChart()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupChart()
    }

    private func setupChart() {
        addSubview(barChartView)

        NSLayoutConstraint.activate([
            barChartView.topAnchor.constraint(equalTo: topAnchor),
            barChartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            barChartView.trailingAnchor.constraint(equalTo: trailingAnchor),
            barChartView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func updateData(steps: [StepData]) {
        var dataEntries: [BarChartDataEntry] = []

        for (index, stepData) in steps.enumerated() {
            let dataEntry = BarChartDataEntry(x: Double(index), y: Double(stepData.steps))
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Шаги")
        chartDataSet.colors = [.blue]
        let chartData = BarChartData(dataSet: chartDataSet)

        barChartView.data = chartData
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: steps.map { stepData in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM"
            return formatter.string(from: stepData.date)
        })
        barChartView.xAxis.granularity = 1
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.axisMinimum = 0
        barChartView.animate(yAxisDuration: 1.0)
    }
}
