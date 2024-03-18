//
//  AddViewController.swift
//  Nado
//
//  Created by 심관혁 on 3/6/24.
//

import UIKit

protocol AddTodoDelegate: AnyObject {
    func addTodoDidSave(todo: ToDo)
    func editTodoDidSave(todo: ToDo)
}

class AddViewController: UIViewController {

    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var inView: UIView!
    
    weak var delegate: AddTodoDelegate?
    
    var todoToEdit: ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inView.clipsToBounds = true
        inView.layer.cornerRadius = 15
        inView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        // 바깥뷰의 투명도
        outView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // 터치 제스쳐
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        
        outView.addGestureRecognizer(tapGesture)
        
        setupKeyboardEvent()
        
        // Modal이 켜졌을 때 키보드로 포커스 이동
        addTextField.becomeFirstResponder()
        
        // 키보드의 수정제안이 표시되면 iOS17 버전 이상에서 멈추는 현상 발생
//        addTextField.autocorrectionType = .no
//        addTextField.spellCheckingType = .no
        
        if let todo = todoToEdit {
            // 수정할 내용
            addTextField.text = todo.title
        }
    }
    
    func setupKeyboardEvent() {
        // 유저의 키보드의 높이에 따라 프레임 조절
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // 입력 완료 버튼을 눌렀을 때
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let title = addTextField.text, !title.isEmpty else {
            let alertController = UIAlertController(title: "경고", message: "제목을 입력해주세요.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "확인", style: .default) { _ in
                self.dismiss(animated: true, completion: nil)
            })
            present(alertController, animated: true, completion: nil)
            return
        }
        
        if let todoToEdits = todoToEdit {
            // Edit
            todoToEdit?.title = title
            delegate?.editTodoDidSave(todo: todoToEdit!)
        } else {
            // Add
            let newItem = ToDo(title: title)
            delegate?.addTodoDidSave(todo: newItem)
        }
        dismiss(animated: true, completion: nil)
    }
    // 유저의 키보드가 나타날 때
    @objc func keyboardWillShow(_ notification: Notification) {
        DispatchQueue.main.async {
            if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                // 키보드가 나타날 때 뷰의 위치를 조절
                let keyboardHeight = keyboardFrame.height
                let newYPosition = self.view.frame.height - keyboardHeight - self.inView.frame.height
                
                UIView.animate(withDuration: 0.3) {
                    self.inView.frame.origin.y = newYPosition
                }
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
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
