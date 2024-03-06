//
//  MainViewController.swift
//  Nado
//
//  Created by 심관혁 on 3/6/24.
//

import UIKit

class MainViewController: UIViewController, AddViewControllerDelegate {
    
    @IBOutlet weak var nothingPage: UIView!
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var explainLabel: UILabel!
    
    // TodoList 배열 생성
    var todoList: [ToDo] = []
    
    // ToDo-List가 존재하는지
    var isTodoExist: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        explainLabel.font = UIFont(name: "NotoSansKR-Regular", size: 18)
        
        presentTodo(isTodoExist)
        
        self.todoTableView.dataSource = self
        self.todoTableView.delegate = self
//        self.loadToDoList() // 유저디폴트에 저장된 목록을 불러오는 함수
    }

    // ToDo-List가 존재하지 않을 때
    func presentTodo(_ isTodoExist: Bool) {
        if isTodoExist {
            todoTableView.isHidden = false
        } else {
            todoTableView.isHidden = true
        }
    }
    
    // ToDoList 저장 함수
    func saveToDo(_ item: ToDo) {
        todoList.append(item)
        if isTodoExist == false { 
            isTodoExist = true
            presentTodo(isTodoExist)
        }
        print("\(todoList)")
        todoTableView.reloadData()
//        let data = self.todoList.map{
//            [
//                "title": $0.title,
//                "done": $0.done,
//                "data": $0.date
//            ]
//        }
//        let userDefaults = UserDefaults.standard
//        userDefaults.set(data, forKey: "todoList")
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Add", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AddViewController") as! AddViewController
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    func loadToDoList() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "todoList") as? [[String: Any]] else { return }
        self.todoList = data.compactMap{
            guard let title = $0["title"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            guard let date = $0["date"] as? Date else { return nil }
            return ToDo(title: title, done: done, date: date)
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        let todo = self.todoList[indexPath.row]
        cell.textLabel?.text = todo.title
        
        if todo.done {
            cell.imageView?.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            cell.imageView?.image = UIImage(systemName: "circle")
        }
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var todo = self.todoList[indexPath.row]
        todo.done = !todo.done
        self.todoList[indexPath.row] = todo
        self.todoTableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
