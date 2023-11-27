//
//  NoteItem.swift
//  IdeaNote
//
//  Created by DongQing on 2023/11/14.
//

import SwiftUI

class NoteModel: Identifiable, Codable {
    var id = UUID()
    var writeTime: String = ""
    var title: String = ""
    var content: String = ""
    
    init(id: UUID = UUID(), writeTime: String, title: String, content: String) {
        self.id = id
        self.writeTime = writeTime
        self.title = title
        self.content = content
    }
}
