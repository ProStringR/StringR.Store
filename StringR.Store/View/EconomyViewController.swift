//
//  EconomyViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit
import Charts

class EconomyViewController: UIViewController {

    weak var dateSegmentControl: UISegmentedControl!
    weak var pieChart: PieChartView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupSegmentControl()
        setupChart()
        setupConstraints()
    }

    private func setupLayout() {
        self.view.backgroundColor = .white
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: "generel_Economy"))
    }

    private func setupSegmentControl() {
        let listOfSegments: [String] = ["Day", "Week", "Month", "Year", "All"]
        self.dateSegmentControl = LayoutController.getSegmentedControl(withItems: listOfSegments, forParent: self.view)
    }

    private func setupChart() {
        let chart = PieChartView()

        let categories = ["Done", "Pending"]
        let categoryAmount = [22, 13]

        var entries = [PieChartDataEntry]()
        for (index, value) in categoryAmount.enumerated() {
            let entry = PieChartDataEntry()
            entry.y = Double(value)
            entry.label = categories[index]
            entries.append(entry)
        }

        let set = PieChartDataSet(entries: entries, label: Constant.emptyString)
        let colors: [UIColor] = [UIColor.green, UIColor.red]
        set.colors = colors

        let data = PieChartData(dataSet: set)
        chart.data = data
        chart.noDataText = "No data available"
        chart.isUserInteractionEnabled = false

        let desc = Description()
        chart.chartDescription = desc
        chart.centerText = "Center text"
        chart.holeRadiusPercent = 0.7
        chart.transparentCircleColor = UIColor.clear

        self.view.addSubview(chart)
        self.pieChart = chart
    }

    private func setupConstraints() {
        Layout.addTopConstraint(on: self.dateSegmentControl, to: self.view.safeAreaLayoutGuide.topAnchor)
        Layout.addLeadingConstraint(on: self.dateSegmentControl, to: self.view.safeAreaLayoutGuide.leadingAnchor)
        Layout.addTrailingConstraint(on: self.dateSegmentControl, to: self.view.safeAreaLayoutGuide.trailingAnchor)
//
//        Layout.addTopConstraint(on: self.pieChart, to: self.dateSegmentControl.bottomAnchor, by: Constant.bigOffset)
//        Layout.addLeadingConstraint(on: self.pieChart, to: self.view.safeAreaLayoutGuide.leadingAnchor)
//        Layout.addTrailingConstraint(on: self.pieChart, to: self.view.safeAreaLayoutGuide.trailingAnchor)

        self.pieChart.translatesAutoresizingMaskIntoConstraints = false
        self.pieChart.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.pieChart.centerXAnchor.constraint(equalTo: self.pieChart.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.pieChart.widthAnchor.constraint(equalToConstant: 600).isActive = true
        self.pieChart.heightAnchor.constraint(equalToConstant: 600).isActive = true

        self.dateSegmentControl.heightAnchor.constraint(equalToConstant: Constant.standardButtonHeight).isActive = true
    }
}
