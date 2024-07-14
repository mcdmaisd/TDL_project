//
//  Options.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-08.
//

import Foundation

enum Options: String, CaseIterable {
    case deadline = "마감일"
    case tag = "태그"
    case priority = "우선순위"
    case addImages = "이미지 추가"
}

enum IconNames: String, CaseIterable {
    case xmark = "calendar.badge.exclamationmark"
    case calendar = "calendar"
    case folder = "folder"
    case flag = "flag.fill"
    case circle = "checkmark.circle"
}

enum CellTitles: String, CaseIterable {
    case today = "오늘"
    case future = "예정"
    case entire = "전체"
    case flag = "깃발표시"
    case completed = "완료됨"
}

