//
//  NewNoteView.swift
//  IdeaNote
//
//  Created by DongQing on 2023/11/15.
//

import SwiftUI

struct NewNoteView: View {
    
    @State var content: String = ""
    @State var isEditing = false
    @State var title: String = ""
    
    @Binding var showNewNoteView: Bool
    @Binding var noteItems: [NoteItem]
    
    @State var showToast = false
    @State var showToastMessage: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                titleView()
                Divider()
                contentView()
            }
            .navigationTitle("新建笔记")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    closeBtnView()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    saveBtnView()
                }
            })
            .toast(present: $showToast, message: $showToastMessage, alignment: .center)
        }
    }

    private func addNote(writeTime:String,title:String,content:String) {
        let note = NoteItem(writeTime: writeTime, title:title,content:content)
        noteItems.append(note)
    }

    
    private func closeBtnView() -> some View {
        Button(action: {
            self.showNewNoteView = false
        }) {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 17))
                .foregroundColor(.gray)
        }
    }
    
    private func saveBtnView() -> some View {
        Button(action: {
            if title.isEmpty {
                self.showToastMessage = "请输入标题"
                self.showToast = true
            } else if content.isEmpty {
                self.showToastMessage = "请输入内容"
                self.showToast = true
            } else {
                self.addNote(writeTime: getCurrentTime(), title: title, content: content)
                self.showNewNoteView = false
            }
        }) {
            Text("完成")
                .font(.system(size: 17))
        }
    }
    
    private func getCurrentTime() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY.MM.dd"
        return dateformatter.string(from: Date())
    }

    
    private func titleView() -> some View {
        TextField("请输入标题", text: $title, onEditingChanged: { editingChanged in
            self.isEditing = editingChanged
        })
        .padding()
    }
    
    private func contentView() -> some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $content)
                .font(.system(size: 17))
                .padding()
            if content.isEmpty {
                Text("请输入内容")
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(.top, 23)
                    .padding(.leading, 19)
            }
        }
    }
}

#Preview {
    NewNoteView(showNewNoteView: .constant(true), noteItems: .constant([]))
}
