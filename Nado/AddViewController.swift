//
//  AddViewController.swift
//  Nado
//
//  Created by 심관혁 on 3/6/24.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var outView: UIView!
    @IBOutlet weak var addTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // 터치 제스쳐
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        
        outView.addGestureRecognizer(tapGesture)
        
        // Modal이 켜졌을 때 키보드로 포커스 이동
        addTextField.becomeFirstResponder()
    }
    
    // 터치 제스쳐를 통해 Modal을 닫음
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
}
