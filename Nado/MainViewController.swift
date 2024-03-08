//
//  MainViewController.swift
//  Nado
//
//  Created by 심관혁 on 3/6/24.
//

import UIKit

class MainViewController: UIViewController, AddTodoDelegate, TodoCellDelegate {
    
    @IBOutlet weak var nothingPage: UIView!
    @IBOutlet weak var explainLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // TodoList 배열 생성
    var todoList: [ToDo] = []
    
    var dataSource: UICollectionViewDiffableDataSource<Section, ToDo>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, ToDo>!
    
    var isExistTodo: Bool = false
    
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        explainLabel.font = UIFont(name: "NotoSansKR-Regular", size: 18)
        
        dataSource = UICollectionViewDiffableDataSource<Section, ToDo>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodoCell", for: indexPath) as? TodoCell else {
                return nil
            }
            cell.configure(itemIdentifier)
            cell.delegate = self
            return cell
        })
        
        snapshot = NSDiffableDataSourceSnapshot<Section, ToDo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(todoList,toSection: .main)
        dataSource.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
        
        if todoList.count < 1 {
            hideCollectionView(isExistTodo)
        }
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(59))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(59))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 22, bottom: 10, trailing: 20)
        section.interGroupSpacing = 15
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    // AddViewController에서 Todo를 Add하는 함수
    func addTodoDidSave(todo: ToDo){
        if todoList.count == 0 {
            isExistTodo = !isExistTodo
            hideCollectionView(isExistTodo)
        }
        todoList.append(todo)
        snapshot.appendItems([todo])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // Todo가 존재하지 않을 때 CollectionView를 숨기기
    func hideCollectionView(_ isExist: Bool) {
        if isExist {
            collectionView.isHidden = false
        } else {
            collectionView.isHidden = true
        }
    }
   
    // TodoCell의 doneButton
    func doneButton(_ todo:ToDo) {
        
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
