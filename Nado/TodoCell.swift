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
    @IBOutlet weak var starButton: UIButton!
    
    let undoneImg: String = "circle"
    let doneImg: String = "checkmark.circle.fill"
    let unstarImg: String = "star"
    let starImg: String = "star.fill"

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
    
    var toggleDoneAction: (() -> Void)?
    var toggleStarAction: (() -> Void)?
    
    func configure(_ todo: ToDo) {
        titleLabel.text = todo.title
        dateLabel.text = DateFormatter.localizedString(from: todo.date, dateStyle: .none, timeStyle: .short)
        doneButton.setImage(nil, for: .normal)
        updateDoneButtonImage(btn: doneButton, done: todo.done, unImg: undoneImg, Img: doneImg)
        updateDoneButtonImage(btn: starButton, done: todo.star, unImg: unstarImg, Img: starImg)
        
    }
    
    func updateDoneButtonImage(btn: UIButton, done: Bool, unImg: String, Img: String) {
        let doneImage = done ? UIImage(systemName: Img)?.withRenderingMode(.alwaysOriginal) : UIImage(systemName: unImg)?.withRenderingMode(.alwaysTemplate)
        btn.setImage(doneImage, for: .normal)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        toggleDoneAction?()
    }
    @IBAction func starButtonTapped(_ sender: Any) {
        toggleStarAction?()
    }
}
