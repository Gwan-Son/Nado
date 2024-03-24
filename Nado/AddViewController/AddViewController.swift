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
    
    // 입력 완료 버튼을 눌렀을 때
    @IBAction func doneButtonTapped(_ sender: Any) {
        // Title을 입력하지 않으면 Alert를 이용하여 경고창 표시
        guard let title = addTextField.text, !title.isEmpty else {
            let alertController = UIAlertController(title: "경고", message: "제목을 입력해주세요.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "확인", style: .default) { _ in
                self.dismiss(animated: true, completion: nil)
            })
            present(alertController, animated: true, completion: nil)
            return
        }
        
        if todoToEdit != nil {
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
    
    // 키보드 동작 감시 종료
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
