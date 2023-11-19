//
//  NoteItem.swift
//  IdeaNote
//
//  Created by DongQing on 2023/11/14.
//

import SwiftUI

class NoteItem: ObservableObject, Identifiable {
    var id = UUID()
    @Published var writeTime: String = ""
    @Published var title: String = ""
    @Published var content: String = ""
    
    init(writeTime: String, title: String, content: String) {
        self.writeTime = writeTime
        self.title = title
        self.content = content
    }
}
