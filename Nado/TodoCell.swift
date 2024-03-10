//
//  TodoCell.swift
//  Nado
//
//  Created by 심관혁 on 3/7/24.
//

import UIKit


class TodoCell: UICollectionViewCell {
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        doneButton.setImage(nil, for: .normal)
    }
    
    var currentTodo: ToDo?
    
    var toggleDoneAction: (() -> Void)?
    
    func configure(_ todo: ToDo) {
        titleLabel.text = todo.title
        dateLabel.text = DateFormatter.localizedString(from: todo.date, dateStyle: .short, timeStyle: .short)
        currentTodo = todo
        doneButton.setImage(nil, for: .normal)
        updateDoneButtonImage()
    }
    
    func updateDoneButtonImage() {
        guard let todo = currentTodo else {return}
        let doneImage = todo.done ? UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysTemplate) : UIImage(systemName: "circle")?.withRenderingMode(.alwaysTemplate)
        doneButton.setImage(doneImage, for: .normal)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        toggleDoneAction?()
    }
}
