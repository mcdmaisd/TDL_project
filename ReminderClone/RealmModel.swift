//
//  RealmModel.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-03.
//

import Foundation
import RealmSwift

class Table: Object {
    @Persisted(primaryKey: true) var id: ObjectId//primary key
    @Persisted var memoTitle: String // 메모제목(필수)
    @Persisted var memoContent: String?// 메모내용(optional) String?
    @Persisted var deadline: String?//마감일(optional) Date?
    @Persisted var tag: String?
    // 왜 convenience 인가?
    // PK인 id는 realm이 알아서 번호를 지정하기 때문에 모든 프로퍼티를 지정해야만 하는 init은 사용 불가능
    convenience init(memoTitle: String, memoContent: String?, deadline: String?, tag: String?) {
        self.init()
        self.memoTitle = memoTitle
        self.memoContent = memoContent
        self.deadline = deadline
        self.tag = tag
    }
}
