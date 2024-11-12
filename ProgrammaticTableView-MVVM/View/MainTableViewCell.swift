//
//  MainTableViewCell.swift
//  ProgrammaticTableView-MVVM
//
//  Created by Bayram Yeleç on 11.11.2024.
//

import UIKit

protocol CellProtocol {
    func setupUI()
    func configure(with model: Todo)
}

class MainTableViewCell: UITableViewCell {
    
    static let identifier: String = "MainTableViewCell"
    let todoLabel = UILabel()
    let tickImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainTableViewCell: CellProtocol {
    func setupUI() {
        tickImageView.contentMode = .scaleAspectFit
        contentView.addSubview(tickImageView)
        tickImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        todoLabel.textColor = .label
        todoLabel.font = .systemFont(ofSize: 16, weight: .bold)
        contentView.addSubview(todoLabel)
        todoLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(tickImageView.snp.left).offset(-20)
        }
    }
    func configure(with model: Todo) {
        todoLabel.text = model.title
        tickImageView.image = model.isTicked ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "circle")
        tickImageView.tintColor = model.isTicked ? .systemGreen : .systemGray
    }
}

