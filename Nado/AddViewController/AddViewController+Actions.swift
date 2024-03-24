//
//  AddViewController+KeyboardActions.swift
//  Nado
//
//  Created by 심관혁 on 3/23/24.
//

import UIKit

extension AddViewController {
    func setupKeyboardEvent() {
        // 유저의 키보드의 높이에 따라 프레임 조절
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
}
