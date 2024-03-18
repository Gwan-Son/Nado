//
//  MainViewController.swift
//  Nado
//
//  Created by 심관혁 on 3/6/24.
//

import UIKit
import SwipeCellKit


class MainViewController: UIViewController, AddTodoDelegate  {
    
    @IBOutlet weak var nothingPage: UIView! // todoList가 존재하지 않을 때 보이는 뷰
    @IBOutlet weak var explainLabel: UILabel! // todoList 설명
    @IBOutlet weak var collectionView: UICollectionView! // todoList collectionView
    
    // TodoList 배열 생성
    var todoList: [ToDo] = ToDo.sampleData
    
    var defaultOptions = SwipeOptions() // SwipeCellKit Options
    var isSwipeRightEnabled = true
    var buttonDisplayMode: ButtonDisplayMode = .imageOnly // SwipeCellKit 표시형식
    var buttonStyle: ButtonStyle = .circular // SwipeCellKit의 버튼 모양
    
    var isExistTodo: Bool = false // todoList의 존재유무
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        explainLabel.font = UIFont(name: "NotoSansKR-Regular", size: 18)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        checkTodoList(todoCount: todoList.count) // todoList가 존재하는지
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Add", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AddViewController") as! AddViewController
        
        vc.todoToEdit = nil
        vc.modalPresentationStyle = .overCurrentContext // addModal을 MainView 위에 띄움
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
        present(vc, animated: true)
    }
}
