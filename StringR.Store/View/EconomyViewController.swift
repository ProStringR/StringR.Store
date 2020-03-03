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

    let orderController = ControlReg.getOrderController
    let economyController = ControlReg.getEconomyController
    weak var dateSegmentControl: UISegmentedControl!
    weak var pieChart: PieChartView!
    weak var dataStackView: UIStackView!
    var economy: EconomyFb?
    var orders: [OrderFb]?
    var pendingAmount = 0
    var doneAmount = 0

    weak var revenue: UILabel!
    weak var expenses: UILabel!
    weak var labour: UILabel!
    weak var profit: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupLabels()
        setupSegmentControl()

        setupChart()
        setupDataStackView()
        setupConstraints()
        getData()
    }

    private func getData() {
//        let spinner = LayoutController.getSpinner(forParent: self.view)
//        self.showSpinner(withSpinner: spinner)
//        ShopSingleton.shared.refreshAndGetShop { (shop) in
//            if let shop = shop {
//                self.orderController.getAllOrders(for: shop, completion: { (orders) in
//                    if let orders = orders {
//                        DispatchQueue.main.async {
//                            self.orders = orders
//                            self.updateUI(with: self.dateSegmentControl.selectedSegmentIndex)
//                        }
//                    }
//                    self.removeSpinner(forSpinner: spinner)
//                })
//            }
//        }
    }

    private func updateUI(with interval: Int) {
        DispatchQueue.main.async {
            let econInterval = EconomyInterval.init(rawValue: interval)
            if let econInterval = econInterval {
                let listOfOrders = self.economyController.getListOfOrders(basedOn: econInterval, with: self.orders)
                let economy = self.economyController.calculateEconomy(basedOn: listOfOrders)

                self.revenue.text = String(Int(economy.revenue))
                self.expenses.text = String(Int(economy.stringExpense))
                self.labour.text = String(Int(economy.expenses))
                self.profit.text = String(Int(economy.profit))

                self.doneAmount = economy.totalStrung - economy.numberOfPendingOrders
                self.pendingAmount = economy.numberOfPendingOrders

                self.pieChart.data = self.getUpdatedChartData()
                self.pieChart.notifyDataSetChanged()
            }
        }
    }

    private func setupLayout() {
        self.view.backgroundColor = .white
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: "generel_Economy"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updateData))
    }

    private func setupLabels() {
        self.revenue = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)
        self.expenses = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)
        self.labour = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)
        self.profit = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)
    }

    private func setupSegmentControl() {
        let listOfSegments: [String] = [
            Utility.getString(forKey: "common_day"),
            Utility.getString(forKey: "common_week"),
            Utility.getString(forKey: "common_month"),
            Utility.getString(forKey: "common_year"),
            Utility.getString(forKey: "common_all")]

        self.dateSegmentControl = LayoutController.getSegmentedControl(withItems: listOfSegments, forParent: self.view)
        self.dateSegmentControl.addTarget(self, action: #selector(statusIndexChanged(_:)), for: .valueChanged)
    }

    private func setupChart() {
        /*
        This chart is 3. party library
         */
        let chart = PieChartView()

        chart.data = getUpdatedChartData()
        chart.noDataText = Utility.getString(forKey: "economy_chart_noData")
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
        let listOfViews: [UILabel] = [
            LayoutController.getLabel(text: Utility.getString(forKey: "economy_revenue"), parentView: self.view),
            LayoutController.getLabel(text: Utility.getString(forKey: "economy_stringExpense"), parentView: self.view)]

        Layout.setLabelAsHeader(labels: listOfViews)
        Layout.centerAlignUILabels(uiLabelArry: listOfViews)
        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func initializeTopValueStackView() -> UIStackView {
        let listOfViews: [UILabel] = [self.revenue, self.expenses]
        Layout.centerAlignUILabels(uiLabelArry: listOfViews)
        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func initializeBottomHeaderStackView() -> UIStackView {
        let listOfViews: [UILabel] = [
            LayoutController.getLabel(text: Utility.getString(forKey: "economy_labour"), parentView: self.view),
            LayoutController.getLabel(text: Utility.getString(forKey: "economy_profit"), parentView: self.view)]

        Layout.setLabelAsHeader(labels: listOfViews)
        Layout.centerAlignUILabels(uiLabelArry: listOfViews)
        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func initializeBottomValueStackView() -> UIStackView {
        let listOfViews: [UILabel] = [self.labour, self.profit]
        Layout.centerAlignUILabels(uiLabelArry: listOfViews)
        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func getUpdatedChartData() -> ChartData {
        let categories = [Utility.getString(forKey: "economy_done"), Utility.getString(forKey: "economy_pending")]
        let categoryAmount = [self.doneAmount, self.pendingAmount]

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

        return data
    }

    private func setupConstraints() {
        Layout.addTopConstraint(on: self.dateSegmentControl, to: self.view.safeAreaLayoutGuide.topAnchor)
        Layout.addLeadingConstraint(on: self.dateSegmentControl, to: self.view.safeAreaLayoutGuide.leadingAnchor, by: Constant.bigOffset)
        Layout.addTrailingConstraint(on: self.dateSegmentControl, to: self.view.safeAreaLayoutGuide.trailingAnchor, by: Constant.bigOffset)

        Layout.addTopConstraint(on: self.pieChart, to: self.dateSegmentControl.bottomAnchor, by: Constant.bigOffset)
        Layout.centerHorizontally(on: self.pieChart, withParent: self.view)
        self.pieChart.widthAnchor.constraint(equalToConstant: 500).isActive = true
        self.pieChart.heightAnchor.constraint(equalToConstant: 500).isActive = true

        Layout.addBottomConstraint(on: self.dataStackView, to: self.view.safeAreaLayoutGuide.bottomAnchor, by: Constant.gigantOffset)
        Layout.addLeadingConstraint(on: self.dataStackView, to: self.view.safeAreaLayoutGuide.leadingAnchor)
        Layout.addTrailingConstraint(on: self.dataStackView, to: self.view.safeAreaLayoutGuide.trailingAnchor)

        self.dateSegmentControl.heightAnchor.constraint(equalToConstant: Constant.standardButtonHeight).isActive = true
    }

    @objc func statusIndexChanged(_ sender: UISegmentedControl) {
        self.updateUI(with: sender.selectedSegmentIndex)
    }

    @objc func updateData() {
        self.getData()
    }
}
