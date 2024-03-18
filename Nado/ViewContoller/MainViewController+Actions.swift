//
//  MainViewController+DataSource.swift
//  Nado
//
//  Created by 심관혁 on 3/14/24.
//

import UIKit

extension MainViewController {
    
    // todo의 ID를 반환
    func todo(withId id: ToDo.ID) -> ToDo {
        let index = todoList.indexOfToDo(withId: id)
        return todoList[index]
    }
    
    func updateCollectionView() {
        todoList.sort { (todo1, todo2) in
            if todo2.done != todo1.done {
                return todo2.done && !todo1.done
            } else {
                return todo1.star && !todo2.star
            }
        }
        collectionView.reloadData()
    }
    
    func updateTodo(_ todo: ToDo) {
        let index = todoList.indexOfToDo(withId: todo.id)
        todoList[index] = todo
    }
    
    func completeTodo(withId id: ToDo.ID) {
        var todo = todo(withId: id)
        todo.done.toggle()
        if todo.done {
            todo.date = Date()
        } else {
            todo.date = nil
        }
        updateTodo(todo)
        updateCollectionView()
    }
    
    func checkStarTodo(withId id: ToDo.ID) {
        var todo = todo(withId: id)
        todo.star.toggle()
        updateTodo(todo)
        updateCollectionView()
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
    
    // AddViewController에서 Todo를 Add하는 함수
    func addTodoDidSave(todo: ToDo){
        todoList.append(todo)
        checkTodoList(todoCount: todoList.count)
        collectionView.reloadData()
    }
    
    // AddViewController에서 Todo를 Edit하는 함수
    func editTodoDidSave(todo: ToDo) {
        updateTodo(todo)
        updateCollectionView()
    }
}
