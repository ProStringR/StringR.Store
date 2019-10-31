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
    weak var dataStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupSegmentControl()
        setupChart()
        setupDataStackView()
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
        let colors: [UIColor] = [Color.darkGrey, Color.lightGrey]
        set.colors = colors

        let data = PieChartData(dataSet: set)
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        chart.data = data
        chart.noDataText = "No data available"
        chart.isUserInteractionEnabled = false

        let desc = Description()
        chart.chartDescription = desc
        chart.holeRadiusPercent = 0.6
        chart.transparentCircleColor = UIColor.clear
        chart.legend.enabled = false

        self.view.addSubview(chart)
        self.pieChart = chart
    }

    private func setupDataStackView() {
        let listOfStackViews: [UIStackView] = [
            initializeTopHeaderStackView(),
            initializeTopValueStackView(),
            initializeBottomHeaderStackView(),
            initializeBottomValueStackView()]

        self.dataStackView = LayoutController.getStackView(content: listOfStackViews, orientation: .vertical, parentView: self.view)
        self.dataStackView.alignment = .fill
    }

    private func initializeTopHeaderStackView() -> UIStackView {
        let listOfViews: [UILabel] = [LayoutController.getLabel(text: "Revenue", parentView: self.view), LayoutController.getLabel(text: "Cost", parentView: self.view)]
        Layout.setLabelAsHeader(labels: listOfViews)
        Layout.centerAlignUILabels(uiLabelArry: listOfViews)
        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func initializeTopValueStackView() -> UIStackView {
        let listOfViews: [UILabel] = [LayoutController.getLabel(text: "2700", parentView: self.view), LayoutController.getLabel(text: "400", parentView: self.view)]
        Layout.centerAlignUILabels(uiLabelArry: listOfViews)
        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func initializeBottomHeaderStackView() -> UIStackView {
        let listOfViews: [UILabel] = [LayoutController.getLabel(text: "Labour", parentView: self.view), LayoutController.getLabel(text: "Profit", parentView: self.view)]
        Layout.setLabelAsHeader(labels: listOfViews)
        Layout.centerAlignUILabels(uiLabelArry: listOfViews)
        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func initializeBottomValueStackView() -> UIStackView {
        let listOfViews: [UILabel] = [LayoutController.getLabel(text: "250", parentView: self.view), LayoutController.getLabel(text: "2050", parentView: self.view)]
        Layout.centerAlignUILabels(uiLabelArry: listOfViews)
        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func setupConstraints() {
        Layout.addTopConstraint(on: self.dateSegmentControl, to: self.view.safeAreaLayoutGuide.topAnchor)
        Layout.addLeadingConstraint(on: self.dateSegmentControl, to: self.view.safeAreaLayoutGuide.leadingAnchor, by: Constant.bigOffset)
        Layout.addTrailingConstraint(on: self.dateSegmentControl, to: self.view.safeAreaLayoutGuide.trailingAnchor, by: Constant.bigOffset)

        Layout.addTopConstraint(on: self.pieChart, to: self.dateSegmentControl.bottomAnchor, by: Constant.bigOffset)
        Layout.addLeadingConstraint(on: self.pieChart, to: self.view.safeAreaLayoutGuide.leadingAnchor)
        Layout.addTrailingConstraint(on: self.pieChart, to: self.view.safeAreaLayoutGuide.trailingAnchor)
        self.pieChart.widthAnchor.constraint(equalToConstant: 500).isActive = true
        self.pieChart.heightAnchor.constraint(equalToConstant: 500).isActive = true

        Layout.addBottomConstraint(on: self.dataStackView, to: self.view.safeAreaLayoutGuide.bottomAnchor, by: Constant.gigantOffset)
        Layout.addLeadingConstraint(on: self.dataStackView, to: self.view.safeAreaLayoutGuide.leadingAnchor)
        Layout.addTrailingConstraint(on: self.dataStackView, to: self.view.safeAreaLayoutGuide.trailingAnchor)

        self.dateSegmentControl.heightAnchor.constraint(equalToConstant: Constant.standardButtonHeight).isActive = true
    }
}
