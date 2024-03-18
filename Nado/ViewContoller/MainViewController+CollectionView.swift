//
//  MainViewController+CollectionView.swift
//  Nado
//
//  Created by 심관혁 on 3/19/24.
//

import UIKit

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // collectionView에 cell을 연결
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let todo = todoList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodoCell", for: indexPath) as! TodoCell
        cell.delegate = self
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        
        cell.configure(todo)
        cell.doneState = todo.done
        cell.toggleDoneAction = { [weak self] in
            self?.completeTodo(withId: todo.id)
        }
        cell.toggleStarAction = { [weak self] in
            self?.checkStarTodo(withId: todo.id)
        }
        
        return cell
    }
    
    // collectionView의 cell 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todoList.count
    }
    
    // collectionVeiw의 margins
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 33, left: 22, bottom: 15, right: 20)
    }
    
    // collectionView cell의 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 42
        return CGSize(width: width, height: 59.0)
    }
}
