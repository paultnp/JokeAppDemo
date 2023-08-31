//
//  JokeViewController.swift
//  JokeAppDemo
//
//  Created by Teenanath on 28/08/23.
//

import UIKit

class JokeViewController: UIViewController, JokeView {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var presenter: JokePresenterProtocol!
    let timeInterval:Double = 5    //Please change this to desired value
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addTableView()
        self.regsiterCell()
        
        let model = JokeModel()
        presenter = JokePresenter(view: self, model: model)
        
        let timer = Timer(timeInterval: timeInterval, repeats: true) { [weak self] (timer) in
            guard let self = self else { return }
            self.timerCalled()
        }
        RunLoop.main.add(timer, forMode: .common)
    }
    
    //MARK: Update View
    func addTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func regsiterCell() {
        tableView.register(JokeTableViewCell.self, forCellReuseIdentifier: "JokeTableViewCell")
    }

    //MARK: JokeView protocol methods
    func insertRowOnTop() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        let cell = self.tableView.cellForRow(at: indexPath) as? JokeTableViewCell
        cell?.animateView()
    }
    
    func removeRowFromLast() {
        let data = presenter.model.jokeArray
        self.tableView.deleteRows(at: [IndexPath.init(row: data.count, section: 0)], with: .automatic)
    }
    
    //MARK: Private Method
    private func timerCalled() {
        presenter.fetchJoke()
    }
    
    private func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy 'at' HH:mm.ss"
        return dateFormatter.string(from: Date())
    }
}

//MARK: TableView Delegate & Datasource

extension JokeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.model.jokeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JokeTableViewCell", for: indexPath) as! JokeTableViewCell
        let data = presenter.model.jokeArray
        cell.lableJoke.text = data[indexPath.row]
        cell.lableDate.text = dateToString()

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
