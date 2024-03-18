//
//  MainViewController+SwipeCellKit.swift
//  Nado
//
//  Created by 심관혁 on 3/19/24.
//

import UIKit
import SwipeCellKit

extension MainViewController: SwipeCollectionViewCellDelegate {
    // collectionView에 SwipeCellKit 적용
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let todo = todoList[indexPath.row]
        
        if orientation == .left {
            guard isSwipeRightEnabled else { return nil }
            let done = SwipeAction(style: .default, title: nil) { action, indexPath in
                let cell = collectionView.cellForItem(at: indexPath) as! TodoCell
                cell.setDone(todo.done, animated: true)
                self.completeTodo(withId: todo.id)
            }
            done.hidesWhenSelected = true
            let descriptor: ActionDescriptor = todo.done ? .done : .undone
            configure(action: done, with: descriptor)
            
            return [done]
        } else {
            let star = SwipeAction(style: .default, title: nil) { action, indexPath in
                let cell = collectionView.cellForItem(at: indexPath) as! TodoCell
                cell.setStar(todo.star, animated: true)
                self.checkStarTodo(withId: todo.id)
            }
            star.hidesWhenSelected = true
            let descriptor: ActionDescriptor = todo.star ? .star : .unstar
            configure(action: star, with: descriptor)
            
            let delete = SwipeAction(style: .destructive, title: nil) { action, indexPath in
                self.todoList.remove(at: indexPath.row)
                self.checkTodoList(todoCount: self.todoList.count)
            }
            configure(action: delete, with: .trash)
            
            return [delete, star]
        }
    }
    
    // collectionView에 SwipeCellKit Options 설정
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = orientation == .left ? .selection : .destructive
        options.transitionStyle = defaultOptions.transitionStyle
        
        switch buttonStyle {
        case .backgroundColor:
            options.buttonSpacing = 11
        case .circular:
            options.buttonSpacing = 4
        #if canImport(Combine)
            if #available(iOS 13.0, *) {
                options.backgroundColor = UIColor.clear
            } else {
                options.backgroundColor = #colorLiteral(red: 0.9467939734, green: 0.9468161464, blue: 0.9468042254, alpha: 1)
            }
        #else
            options.backgroundColor = #colorLiteral(red: 0.9467939734, green: 0.9468161464, blue: 0.9468042254, alpha: 1)
        #endif
        }
        
        return options
    }
    
    // SwipeButton 구성
    func configure(action: SwipeAction, with descriptor: ActionDescriptor) {
        action.image = descriptor.image(forStyle: buttonStyle, displayMode: buttonDisplayMode)
        
        switch buttonStyle {
        case .backgroundColor:
            action.backgroundColor = descriptor.color(forStyle: buttonStyle)
        case .circular:
            action.backgroundColor = .clear
            action.textColor = descriptor.color(forStyle: buttonStyle)
            action.font = .systemFont(ofSize: 13)
            action.transitionDelegate = ScaleTransition.default
        }
    }
}

