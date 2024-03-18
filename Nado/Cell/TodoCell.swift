//
//  TodoCell.swift
//  Nado
//
//  Created by 심관혁 on 3/7/24.
//

import UIKit
import SwipeCellKit


class TodoCell: SwipeCollectionViewCell {
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    let undoneImg: String = "circle"
    let doneImg: String = "checkmark.circle.fill"
    let unstarImg: String = "star"
    let starImg: String = "star.fill"
    
    var animator: Any?
    
    var doneState = false {
        didSet {
            updateDoneButtonImage(btn: doneButton, done: doneState, unImg: undoneImg, Img: doneImg)
        }
    }
    
    var starState = false {
        didSet {
            updateDoneButtonImage(btn: starButton, done: starState, unImg: unstarImg, Img: starImg)
        }
    }
    
    // Done의 상태를 변경함
    func setDone(_ done: Bool, animated: Bool) {
        let closure = {
            self.doneState = done
        }
        if #available(iOS 10, *), animated {
            var localAnimator = self.animator as? UIViewPropertyAnimator
            localAnimator?.stopAnimation(true)
            
            localAnimator = done ? UIViewPropertyAnimator(duration: 1.0, dampingRatio: 0.4) : UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1.0)
            localAnimator?.addAnimations(closure)
            localAnimator?.startAnimation()
            
            self.animator = localAnimator
        } else {
            closure()
        }
    }
    
    // Star의 상태를 변경함
    func setStar(_ star: Bool, animated: Bool) {
        let closure = {
            self.starState = star
        }
        if #available(iOS 10, *), animated {
            var localAnimator = self.animator as? UIViewPropertyAnimator
            localAnimator?.stopAnimation(true)
            
            localAnimator = star ? UIViewPropertyAnimator(duration: 1.0, dampingRatio: 0.4) : UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1.0)
            localAnimator?.addAnimations(closure)
            localAnimator?.startAnimation()
            
            self.animator = localAnimator
        } else {
            closure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        doneButton.setImage(nil, for: .normal)
        titleLabel.attributedText = nil
    }
    
    // 옵셔널 함수로 선언해서 MainViewController에서 수정
    var toggleDoneAction: (() -> Void)?
    var toggleStarAction: (() -> Void)?
    
    // cell 구성
    func configure(_ todo: ToDo) {
        titleLabel.text = todo.title
        if todo.date == nil {
            dateLabel.text = ""
        } else {
            dateLabel.text = DateFormatter.localizedString(from: todo.date!, dateStyle: .none, timeStyle: .short)
        }
        titleLabel.applyStrikeThroughIfDone(todo.done)
        updateDoneButtonImage(btn: doneButton, done: todo.done, unImg: undoneImg, Img: doneImg)
        updateDoneButtonImage(btn: starButton, done: todo.star, unImg: unstarImg, Img: starImg)
        
    }
    
    // 버튼 이미지 변경
    func updateDoneButtonImage(btn: UIButton, done: Bool, unImg: String, Img: String) {
        let doneImage = done ? UIImage(systemName: Img)?.withRenderingMode(.alwaysOriginal) : UIImage(systemName: unImg)?.withRenderingMode(.alwaysTemplate)
        btn.setImage(doneImage, for: .normal)
    }
    
    // Done버튼
    @IBAction func doneButtonTapped(_ sender: Any) {
        toggleDoneAction?()
    }
    
    // Star버튼
    @IBAction func starButtonTapped(_ sender: Any) {
        toggleStarAction?()
    }
}

// Label에 삭제선 표시하기
extension UILabel {
    func applyStrikeThroughIfDone(_ done: Bool) {
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        if done {
            attributedString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            self.textColor = .lightGray
        } else {
            attributedString.removeAttribute(.strikethroughStyle, range: NSRange(location: 0, length: attributedString.length))
            self.textColor = .black
        }
        self.attributedText = attributedString
    }
}
