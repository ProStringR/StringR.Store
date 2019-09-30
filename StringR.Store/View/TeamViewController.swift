//
//  TeamViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class TeamViewController: UIViewController {

    weak var teamTableView: UITableView!
    var stringers: [Stringer]?

    let teamController = ControlReg.getTeamController

    override func viewDidLoad() {
        super.viewDidLoad()

        let stringer = Stringer.init(userId: "mc97",
                                     name: "Marcus",
                                     birthday: 12345,
                                     email: "mac@gmail.com",
                                     phoneNumber: "12345678",
                                     address: Address(street: "Vimmelskaftet", zipCode: "4300", city: "Holbaek", country: "Denmark", longitude: 1234, latitude: 1234),
                                     preferedRacketType: RacketType.TENNIS)

        do {
            try teamController.postStringer(stringer: stringer)
        } catch {
            print("Something went wrong.")
        }

        setLayout()
        setupTableView()
        getStringers()
        setupConstraints()
    }

    private func getStringers() {
        // Call controller to get team data

        // Store the team in the stringers array

        // Reload the tableView
        self.teamTableView.reloadData()
    }

    private func setLayout() {
        self.view.backgroundColor = .white
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: "generel_Team"))
    }

    private func setupTableView() {
        self.teamTableView = LayoutController.getTableView(cellType: UserCell.self, cellIdentifier: UserCell.identifier, parentView: self.view)

        self.teamTableView.delegate = self
        self.teamTableView.dataSource = self
    }

    private func setupConstraints() {
        Layout.setupFullPageConstraints(forView: self.teamTableView, onParentView: self.view)
    }
}

extension TeamViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let team = self.stringers {
            return team.count
        }
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        guard let team = self.stringers else { return UITableViewCell() }

        // swiftlint:disable force_cast
        let cell = self.teamTableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
        // swiftlint:enable force_cast

//        let currentStringer = team[indexPath.row]
//
//        cell.nameLabel.text = currentStringer.name
//        cell.phoneNumberLabel.text = currentStringer.phoneNumber

        // This needs to replaced with the code above...
        cell.nameLabel.text = "Marcus August Christiansen"
        cell.phoneNumberLabel.text = "25722345"

        cell.accessoryType = .detailButton
        cell.tintColor = .black
        return cell
    }
}

extension TeamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let viewControllerToPresent = StringerDetailViewController()
        viewControllerToPresent.stringerName = "Marcus August Christiansen"

        let popup = LayoutController.getPopupView(viewControllerToPresent: viewControllerToPresent)
        self.navigationController?.present(popup, animated: true, completion: nil)
    }
}
