//
//  MainViewController.swift
//  Nado
//
//  Created by 심관혁 on 3/6/24.
//

import UIKit

class MainViewController: UIViewController, AddTodoDelegate {
    
    @IBOutlet weak var nothingPage: UIView!
    @IBOutlet weak var explainLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // TodoList 배열 생성
    var todoList: [ToDo] = []
    
    
    var isExistTodo: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        explainLabel.font = UIFont(name: "NotoSansKR-Regular", size: 18)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        
        
        if todoList.count < 1 {
            hideCollectionView(isExistTodo)
        }
    }
    
    // AddViewController에서 Todo를 Add하는 함수
    func addTodoDidSave(todo: ToDo){
        if todoList.count == 0 {
            isExistTodo = !isExistTodo
            hideCollectionView(isExistTodo)
        }
        todoList.append(todo)
        collectionView.reloadData()
    }
    
    // Todo가 존재하지 않을 때 CollectionView를 숨기기
    func hideCollectionView(_ isExist: Bool) {
        if isExist {
            collectionView.isHidden = false
        } else {
            collectionView.isHidden = true
        }
    }
    
    func toggleDone(indexPath: IndexPath) {
        todoList[indexPath.item].done.toggle()
        collectionView.reloadData()
    }
    
    func toggleStar(indexPath: IndexPath) {
        todoList[indexPath.item].star.toggle()
        collectionView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Add", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AddViewController") as! AddViewController
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
        present(vc, animated: true)
    }
    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodoCell", for: indexPath) as? TodoCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(todoList[indexPath.item])
        cell.toggleDoneAction = { [weak self] in
            self?.toggleDone(indexPath: indexPath)
        }
        cell.toggleStarAction = { [weak self] in
            self?.toggleStar(indexPath: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width - 42
        let height: CGFloat = collectionView.bounds.height / 10
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let edge = UIEdgeInsets(top: 20, left: 22, bottom: 10, right: 20)
        return edge
    }
}
