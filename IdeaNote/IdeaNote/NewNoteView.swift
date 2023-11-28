//
//  NewNoteView.swift
//  IdeaNote
//
//  Created by DongQing on 2023/11/15.
//

import SwiftUI

struct NewNoteView: View {
    
    @EnvironmentObject var viewModel: NoteViewModel

    @State var noteModel: NoteModel

    // 关闭弹窗
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                titleView()
                Divider()
                contentView()
            }
            .navigationTitle(viewModel.isAdd ? "新建笔记" : "编辑笔记")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    closeBtnView()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    saveBtnView()
                }
            })
            .toast(present: $viewModel.showToast, message: $viewModel.showToastMessage)
        }
    }
    
    private func closeBtnView() -> some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 17))
                .foregroundColor(.gray)
        }
    }

    func saveBtnView() -> some View {
        Button(action: {
            if viewModel.isAdd { // 新增
                if viewModel.title.isEmpty {
                    viewModel.showToast = true
                    viewModel.showToastMessage = "请输入标题"
                } else if viewModel.content.isEmpty {
                    viewModel.showToast = true
                    viewModel.showToastMessage = "请输入内容"
                } else {
                    // 新增一条笔记
                    self.viewModel.addItem(writeTime: viewModel.getCurrentTime(), title: viewModel.title, content: viewModel.content)
                    // 关闭弹窗
                    self.presentationMode.wrappedValue.dismiss()
                }
            } else { // 编辑
                if viewModel.title.isEmpty {
                    viewModel.showToast = true
                    viewModel.showToastMessage = "标题不能为空"
                } else if viewModel.content.isEmpty {
                    viewModel.showToast = true
                    viewModel.showToastMessage = "内容不能为空"
                } else {
                    // 保存一条新笔记
                    self.viewModel.editItem(item: noteModel)
                    // 关闭弹窗
                    self.presentationMode.wrappedValue.dismiss()
                }
            }

        }) {
            Text("完成")
                .font(.system(size: 17))
        }
    }

    
    private func titleView() -> some View {
        TextField("请输入标题", text: viewModel.isAdd ? $viewModel.title : $noteModel.title)
            .padding()
    }
    
    private func contentView() -> some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: viewModel.isAdd ? $viewModel.content : $noteModel.content)
                .font(.system(size: 17))
                .padding()
            if viewModel.isAdd ? (viewModel.content.isEmpty) : (noteModel.content.isEmpty) {
                Text("请输入内容")
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(.top, 23)
                    .padding(.leading, 19)
            }
        }
    }
}

#Preview {
    NewNoteView(noteModel: NoteModel(writeTime: "", title: "", content: "")).environmentObject(NoteViewModel())
}
