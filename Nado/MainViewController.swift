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
    
    var dataSource: UICollectionViewDiffableDataSource<Section, ToDo>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, ToDo>!
    
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
            return cell
        })
        
        snapshot = NSDiffableDataSourceSnapshot<Section, ToDo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(todoList,toSection: .main)
        dataSource.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
        
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
    
    func addTodoDidSave(todo: ToDo){
        todoList.append(todo)
        snapshot.appendItems([todo])
        dataSource.apply(snapshot, animatingDifferences: true)
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
