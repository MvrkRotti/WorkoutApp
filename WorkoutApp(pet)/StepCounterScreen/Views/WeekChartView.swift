//
//  WeekChartView.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 04.08.2024.
//

import UIKit
import Charts
import DGCharts

final class WeekChartView: BarChartView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        xAxis.labelPosition = .bottom
        xAxis.labelRotationAngle = 45
        xAxis.drawGridLinesEnabled = false
        xAxis.granularity = 1
        xAxis.setLabelCount(7, force: true)
        xAxis.drawLabelsEnabled = false // Отключаем метки на оси X

        leftAxis.drawGridLinesEnabled = false
        leftAxis.axisMinimum = 0
        leftAxis.granularity = 1
        leftAxis.labelCount = 7
        leftAxis.valueFormatter = DefaultAxisValueFormatter(decimals: 0)

        rightAxis.enabled = false
        chartDescription.enabled = false
        legend.enabled = false
    }

    func updateData(steps: [StepData]) {
        let datesOfWeek = getDatesForCurrentWeek()
        var dataEntries: [BarChartDataEntry] = []
        var maxSteps = 0
        let currentDate = Date()

        for (index, date) in datesOfWeek.enumerated() {
            if let stepData = steps.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
                let dataEntry = BarChartDataEntry(x: Double(index), y: Double(stepData.steps))
                dataEntries.append(dataEntry)
                maxSteps = max(maxSteps, stepData.steps)
            } else {
                let dataEntry = BarChartDataEntry(x: Double(index), y: 0)
                dataEntries.append(dataEntry)
            }
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Шаги")
        chartDataSet.colors = dataEntries.map { entry in
            let isToday = Calendar.current.isDate(datesOfWeek[Int(entry.x)], inSameDayAs: currentDate)
            return isToday ? ColorResources.customRed : ColorResources.customBlue
        }
        let chartData = BarChartData(dataSet: chartDataSet)

        data = chartData
        leftAxis.axisMaximum = Double(maxSteps) * 1.2
        notifyDataSetChanged()
    }
    
    private func getDatesForCurrentWeek() -> [Date] {
        var dates: [Date] = []
        let calendar = Calendar.current
        let currentDate = Date()
        
        // Найти дату понедельника текущей недели
        let weekDay = calendar.component(.weekday, from: currentDate)
        let daysToMonday = (weekDay + 5) % 7
        let startOfWeek = calendar.date(byAdding: .day, value: -daysToMonday, to: currentDate)!

        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
                dates.append(date)
            }
        }
        
        return dates
    }
}
