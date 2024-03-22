//
//  ToDo.swift
//  Nado
//
//  Created by 심관혁 on 3/6/24.
//

import Foundation

struct ToDo: Identifiable {
    var id: String = UUID().uuidString // 작업 id
    var title: String // 작업 이름
    var done: Bool = false // 작업 완료 여부
    var createDate: Date = Date.now // 작업 생성 시간
    var doneDate: Date? = nil // 작업 완료 시간
    var star: Bool = false // 즐겨찾기
}
extension [ToDo] {
    func indexOfToDo(withId id: ToDo.ID) -> Self.Index {
        guard let index = firstIndex(where: { $0.id == id}) else {
            fatalError()
        }
        return index
    }
}

#if DEBUG
extension ToDo {
    static var sampleData = [
        ToDo(title: "공부하기", createDate: Date().addingTimeInterval(800.0)),
        ToDo(title: "운동하기", createDate: Date().addingTimeInterval(14000.0)),
        ToDo(title: "밥먹기", createDate: Date().addingTimeInterval(24000.0)),
        ToDo(title: "잠자기", createDate: Date().addingTimeInterval(3200.0)),
        ToDo(title: "공부하기", createDate: Date().addingTimeInterval(60000.0)),
        ToDo(title: "운동하기", createDate: Date().addingTimeInterval(72000.0))
    ]
}

#endif
