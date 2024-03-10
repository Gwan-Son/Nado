//
//  AddViewController.swift
//  Nado
//
//  Created by 심관혁 on 3/6/24.
//

import UIKit

protocol AddTodoDelegate: AnyObject {
    func addTodoDidSave(todo: ToDo)
}

class AddViewController: UIViewController {

    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var inView: UIView!
    
    weak var delegate: AddTodoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 유저의 키보드의 높이에 따라 프레임 조절
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        inView.clipsToBounds = true
        inView.layer.cornerRadius = 15
        inView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        // 바깥뷰의 투명도
        outView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // 터치 제스쳐
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        
        outView.addGestureRecognizer(tapGesture)
        
        // Modal이 켜졌을 때 키보드로 포커스 이동
        addTextField.becomeFirstResponder()
    }
    
    // 입력 완료 버튼을 눌렀을 때
    @IBAction func doneButtonTapped(_ sender: Any) {
        let title = addTextField.text ?? ""
        let done = false
        let date = Date()
        let star = false
        
        let newItem = ToDo(title: title, done: done, date: date, star: star)
        
        delegate?.addTodoDidSave(todo: newItem)
        dismiss(animated: true, completion: nil)
    }
    // 유저의 키보드가 나타날 때
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // 키보드가 나타날 때 뷰의 위치를 조절
            let keyboardHeight = keyboardFrame.height
            let newYPosition = view.frame.height - keyboardHeight - inView.frame.height
            
            UIView.animate(withDuration: 0.3) {
                self.inView.frame.origin.y = newYPosition
            }
        }
    }
    
    // 터치 제스쳐를 통해 Modal을 닫음
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    // 키보드 동작 감시 종료
    deinit {
            NotificationCenter.default.removeObserver(self)
    }
}
