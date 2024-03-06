//
//  MainViewController.swift
//  Nado
//
//  Created by 심관혁 on 3/6/24.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var nothingPage: UIView!
    @IBOutlet weak var todoTableView: UITableView!
    
    @IBOutlet weak var explainLabel: UILabel!
    
    
    // ToDo-List가 존재하는지
    var isTodoExist: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        explainLabel.font = UIFont(name: "NotoSansKR-Regular", size: 18)
        
        presentTodo(isTodoExist)
    }

    // ToDo-List가 존재하지 않을 때
    func presentTodo(_ isTodoExist: Bool) {
        if isTodoExist {
            todoTableView.isHidden = false
        } else {
            todoTableView.isHidden = true
        }
    }
    @IBAction func addButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Add", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AddViewController") as! AddViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
}
