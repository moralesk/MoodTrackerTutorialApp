//
//  MoodEntriesViewController.swift
//  MoodTracker
//
//  Created by Kelly Morales on 3/16/18.
//  Copyright © 2018 Kelly Morales. All rights reserved.
//

import Foundation
import UIKit

public var entries: [MoodEntry] = []

class MoodEntriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)

    // MARK: Built-in Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = .Entries_Title
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        let addEntryButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEntryAction))
        self.navigationItem.rightBarButtonItem = addEntryButton
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: Built-in UITableViewDelegate & UITableViewDataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = entries[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = entry.getText()
        cell.backgroundColor = entry.getColor()
        return cell
    }

    // MARK: UIBarButtonItem Selector
    @objc private func addEntryAction() {
        let entryViewController = MoodEntryViewController()
        navigationController?.pushViewController(entryViewController, animated: true)
    }
}
