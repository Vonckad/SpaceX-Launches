//
//  LaunchesTableViewController.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 10.04.22.
//

import UIKit

class LaunchesTableViewController: UITableViewController {

    private var whiteColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    private var activityIndicatorView = UIActivityIndicatorView(style: .large)
    private var launchesModel: LaunchesModel = .init(docs: []) {
        didSet {
            tableView.reloadData()
        }
    }
    
    var rocketName: String
    var rocketID: String
    
    init(rocketName: String, rocketID: String) {
        self.rocketName = rocketName
        self.rocketID = rocketID
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = rocketName
        configureTableView()
        configureActivityIndicatorView()
        loadLaunches()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = whiteColor
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : whiteColor]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : whiteColor]
        self.navigationController?.navigationBar.layoutMargins.left = 32
        activityIndicatorView.layer.position = view.center
    }
    
    private func configureTableView() {
        tableView.register(LaunchesTableViewCell.self, forCellReuseIdentifier: LaunchesTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.showsVerticalScrollIndicator = false
//        tableView.contentInset = .init(top: 0, left: 32, bottom: 0, right: 32)
    }
    
    private func configureActivityIndicatorView() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = whiteColor
        tableView.backgroundView = activityIndicatorView
    }

    private func loadLaunches() {
        let service: ServiceFetcherProtocol = ServiceFetcher()
        service.fetchSpaceRokets(rocket: rocketID) { launches in
            guard let launches = launches else {
                self.activityIndicatorView.startAnimating()
                self.createAlertView()
                return }
            self.launchesModel = launches
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    private func createAlertView() {
        let allert = UIAlertController.init(title: "Сбой загрузки!", message: "Проверьте подключение к интернету", preferredStyle: .alert)
        let reloadAction = UIAlertAction(title: "Обновить", style: .default) { _ in
            self.loadLaunches()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive) { _ in
            self.navigationController?.popViewController(animated: true)
        }

        allert.addAction(reloadAction)
        allert.addAction(cancelAction)
        present(allert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return UIView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return launchesModel.docs.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchesTableViewCell.reuseIdentifier, for: indexPath) as! LaunchesTableViewCell
        cell.addData(title: launchesModel.docs[indexPath.section].name ?? "",
                     date: launchesModel.docs[indexPath.section].date_utc ?? "",
                     isSuccess: launchesModel.docs[indexPath.section].success ?? false)
        cell.contentView.layoutMargins = .init(top: 0, left: 32, bottom: 0, right: 32)
        return cell
    }
}
