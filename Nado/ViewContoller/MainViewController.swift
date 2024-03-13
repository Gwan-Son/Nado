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
    
    var dataSource: DataSource!
    // TodoList 배열 생성
    var todoList: [ToDo] = ToDo.sampleData
    
    
    var isExistTodo: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        explainLabel.font = UIFont(name: "NotoSansKR-Regular", size: 18)
        
//        collectionView.dataSource = self
//        collectionView.delegate = self
        
        let layout = layout()
        
        collectionView.collectionViewLayout = layout
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodoCell", for: indexPath) as? TodoCell else{
                return UICollectionViewCell()
            }
            cell.configure(self.todoList[indexPath.item])
            cell.toggleDoneAction = { [weak self] in
                self?.completeTodo(withId: itemIdentifier)
            }
            cell.toggleStarAction = { [weak self] in
                self?.checkStarTodo(withId: itemIdentifier)
            }
            return cell
        })
        
        updateSnapshot()
        
        collectionView.dataSource = dataSource
        
        checkTodoList(todoCount: todoList.count)
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(59))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(3))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        group.interItemSpacing = .fixed(15)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 22, bottom: 0, trailing: 20)
        
        
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    // AddViewController에서 Todo를 Add하는 함수
    func addTodoDidSave(todo: ToDo){
        todoList.append(todo)
        checkTodoList(todoCount: todoList.count)
        updateSnapshot()
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
