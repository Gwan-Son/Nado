//
//  TodoCell.swift
//  Nado
//
//  Created by 심관혁 on 3/7/24.
//

import UIKit

protocol TodoCellDelegate: AnyObject {
    func doneButton(_ todo: ToDo)
}

class TodoCell: UICollectionViewCell {
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    weak var delegate: TodoCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1
    }
    
    
    func configure(_ todo: ToDo) {
        if todo.done == true{
            doneButton.setImage(UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        } else {
            doneButton.setImage(UIImage(systemName: "circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        titleLabel.text = todo.title
        dateLabel.text = "00:00"
    }
    @IBAction func doneButtonTapped(_ sender: Any) {
        
    }
}
