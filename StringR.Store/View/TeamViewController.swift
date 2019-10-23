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
    let shopController = ControlReg.getShopController

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setupTableView()
        getStringers()
        setupConstraints()
    }

    private func getStringers() {
        let spinner = LayoutController.getSpinner(forParent: self.view)
        self.showSpinner(withSpinner: spinner)
        // Call controller to get team data
        teamController.getStringers(fromTeamId: "teamMJ") { (stringers) in
            if let stringers = stringers {
                // Store the team in the stringers array
                self.stringers = stringers
            }

            self.updateUI()
            self.removeSpinner(forSpinner: spinner)
        }
    }

    private func updateUI() {
        // Reload the tableView in UI thread
        DispatchQueue.main.async {
            self.teamTableView.reloadData()
        }
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
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let team = self.stringers else { return UITableViewCell() }

        // swiftlint:disable force_cast
        let cell = self.teamTableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
        // swiftlint:enable force_cast

        let currentStringer = team[indexPath.row]

        cell.nameLabel.text = currentStringer.name
        cell.phoneNumberLabel.text = currentStringer.phoneNumber

        cell.accessoryType = .detailButton
        cell.tintColor = .black
        return cell
    }
}

extension TeamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let stringers = self.stringers else { return }

        let viewControllerToPresent = StringerDetailViewController()
        viewControllerToPresent.delegate = self
        viewControllerToPresent.currentStringer = stringers[indexPath.row]

        let popup = LayoutController.getPopupView(viewControllerToPresent: viewControllerToPresent)
        self.navigationController?.present(popup, animated: true, completion: nil)

        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }
}

extension TeamViewController: RemoveStringerDelegate {
    func removeStringer(stringer: Stringer) {
        self.dismiss(animated: true) {
            self.stringers?.removeAll(where: {$0.userId == stringer.userId})
            let team = self.teamController.createTeam(of: self.stringers, withId: "teamMJ")

            if let team = team {
                self.teamController.putTeam(team: team) { (succes) in
                    if succes {
                        self.updateUI()
                    } else {
                        self.stringers?.append(stringer)

                        // Jump to UI thread and present the alert
                        DispatchQueue.main.async {
                            let alert = LayoutController.getAlert(withTitle: "Ups...", withMessage: "Something went wrong removing your stringer")
                            alert.addAction(UIAlertAction(title: Utility.getString(forKey: "common_cancel"), style: .cancel, handler: nil))
                            alert.addAction(UIAlertAction(title: Utility.getString(forKey: "common_tryAgain"), style: .default, handler: { (alert) in
                                _ = alert
                                // try again
                                self.removeStringer(stringer: stringer)
                            }))

                            // present the alert
                            self.present(alert, animated: true)
                        }
                    }
                }
            }
            self.closeAction()
        }
    }

    func closeAction() {
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
}
