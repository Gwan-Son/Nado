//
//  MainViewController+DataSource.swift
//  Nado
//
//  Created by 심관혁 on 3/14/24.
//

import UIKit

extension MainViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, ToDo.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, ToDo.ID>
    
    func updateSnapshot(reloading ids: [ToDo.ID] = []) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(todoList.map {$0.id})
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
    }
    
    func todo(withId id: ToDo.ID) -> ToDo {
        let index = todoList.indexOfToDo(withId: id)
        return todoList[index]
    }
    
    func updateTodo(_ todo: ToDo) {
        let index = todoList.indexOfToDo(withId: todo.id)
        todoList[index] = todo
    }
    
    func completeTodo(withId id: ToDo.ID) {
        var todo = todo(withId: id)
        todo.done.toggle()
        updateTodo(todo)
        updateSnapshot(reloading: [id])
    }
    
    func checkStarTodo(withId id: ToDo.ID) {
        var todo = todo(withId: id)
        todo.star.toggle()
        updateTodo(todo)
        updateSnapshot(reloading: [id])
    }
    
    // todoList가 존재하지 않을 때 collectionView를 숨김
    func checkTodoList(todoCount: Int){
        if todoCount < 1 {
            isExistTodo = false
        } else {
            isExistTodo = true
        }
        if isExistTodo {
            collectionView.isHidden = false
        } else {
            collectionView.isHidden = true
        }
    }
}
