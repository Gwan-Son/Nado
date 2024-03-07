//
//  ToDo.swift
//  Nado
//
//  Created by 심관혁 on 3/6/24.
//

import Foundation

struct ToDo: Hashable {
    var title: String // 작업 이름
    var done: Bool // 작업 완료 여부
    var date: Date // 작업 완료 시간
}
