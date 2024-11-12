//
//  MainTableView.swift
//  ProgrammaticTableView-MVVM
//
//  Created by Bayram Yeleç on 11.11.2024.
//

import UIKit
import SnapKit

class MainTableView: UIView {
    
    let tableView = UITableView()
    var model: [Todo] = []
    var todoSelected: ((Int) -> Void)?
    var todoDeleted: ((Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        makeConstraint()
        updateTableView(model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    func makeConstraint(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func updateTableView(_ model: [Todo]){
        self.model = model
        tableView.reloadData()
    }
    
}

extension MainTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        let models = model[indexPath.row]
        cell.configure(with: models)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoDeleted?(indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todoSelected?(indexPath.row)
    }
    
}


