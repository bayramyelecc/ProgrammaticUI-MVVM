//
//  ViewController.swift
//  ProgrammaticTableView-MVVM
//
//  Created by Bayram Yeleç on 11.11.2024.
//

import UIKit
import SnapKit

protocol mainVCFuncProtocol {
    func makeUI()
    func configureUI()
    func drawUI()
}

class MainVC: UIViewController {
    
    private var titleLabel = UILabel()
    private let addButton = UIButton()
    private let tableView = MainTableView()
    
    private var viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup(){
        configureUI()
        drawUI()
        makeUI()
        updateTableView()
    }
}

extension MainVC: mainVCFuncProtocol {
    func configureUI() {
        view.addSubview(tableView)
        titleLabel.textAlignment = .center
        titleLabel.text = "To-Do List"
        titleLabel.font = .systemFont(ofSize: 25, weight: .black)
        navigationItem.titleView = titleLabel
        view.addSubview(titleLabel)
        addButton.titleLabel?.font = .systemFont(ofSize: 25, weight: .black)
        addButton.setTitle("+", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 35
        addButton.clipsToBounds = true
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        view.addSubview(addButton)

    }
    
    func drawUI() {
        view.backgroundColor = .systemBackground
    }
    
    func makeUI() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        addButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.height.width.equalTo(70)
        }
    }
    @objc func addButtonTapped(){
        print("Add button clicked!")
        let alert = UIAlertController(title: "Add Todo", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter Todo"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                self.viewModel.addTodo(title: text)
                self.tableView.updateTableView(self.viewModel.model)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    func updateTableView() {
        tableView.todoSelected = { [weak self] task in
            self?.viewModel.toggleTodo(at: task)
            self?.tableView.updateTableView(self?.viewModel.model ?? [])
        }
        tableView.todoDeleted = { [weak self] task in
            self?.viewModel.deleteTodo(at: task)
            self?.tableView.updateTableView(self?.viewModel.model ?? [])
        }
        tableView.updateTableView(viewModel.model)
    }
    
}


