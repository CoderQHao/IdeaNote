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
        }
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
            self.showNewNoteView = false
        }) {
            Text("完成")
                .font(.system(size: 17))
        }
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
    NewNoteView(showNewNoteView: .constant(true))
}
