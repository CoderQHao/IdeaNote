//
//  ContentView.swift
//  IdeaNote
//
//  Created by DongQing on 2023/11/14.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: NoteViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                if !viewModel.isSearching && viewModel.noteModels.isEmpty {
                    noDataView()
                } else {
                    VStack {
                        searchBarView()
                        noteListView()
                    }
                }
                newBtnView()
            }
            .navigationTitle("笔记App")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $viewModel.showNewNoteView) {
            NewNoteView(noteModel: NoteModel(writeTime: "", title: "", content: ""))
        }
    }
    
    /// 缺省图
    private func noDataView() -> some View {
        VStack {
            Image("mynote_empty")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Text("记录下这个世界的点滴")
                .font(.system(size: 17))
                .bold()
                .foregroundStyle(.gray)
        }
    }

    /// 新增笔记按钮
    private func newBtnView() -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    self.viewModel.isAdd = true
                    self.viewModel.writeTime = ""
                    self.viewModel.title = ""
                    self.viewModel.content = ""
                    self.viewModel.showNewNoteView = true
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.blue)
                })
            }
        }
        .padding(.bottom, 32)
        .padding(.trailing, 32)
    }
    
    /// 搜索
    private func searchBarView() -> some View {
        TextField("搜索内容", text: $viewModel.searchText)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(20)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    
                    // 编辑时显示清除按钮
                    if !viewModel.searchText.isEmpty {
                        Button(action: {
                            self.viewModel.searchText = ""
                            self.viewModel.loadItems()
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
            .padding(.horizontal, 10)
            .onChange(of: viewModel.searchText) { _ in
                if !viewModel.searchText.isEmpty {
                    self.viewModel.isSearching = true
                    self.viewModel.searchContet()
                } else {
                    viewModel.searchText = ""
                    self.viewModel.isSearching = false
                    self.viewModel.loadItems()
                }
            }
    }
    
    func noteListView() -> some View {
        List {
            ForEach(viewModel.noteModels) { NoteListRow(noteModel: $0) }
        }
        .listStyle(InsetListStyle())
    }
}

struct NoteListRow: View {
    
    @EnvironmentObject var viewModel: NoteViewModel
    
    @State private var showingActionSheet = false
    @State private var showEditNoteView = false
    
    
    var noteModel: NoteModel
    
    var body: some View {
        HStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(noteModel.writeTime)
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                    Text(noteModel.title)
                        .font(.system(size: 17))
                        .foregroundStyle(.black)
                    Text(noteModel.content)
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                }
                .onTapGesture {
                    self.viewModel.isAdd = false
                    showEditNoteView.toggle()
                }
                Spacer()
                
                Button(action: {
                    showingActionSheet.toggle()
                }, label: {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(.gray)
                        .font(.system(size: 23))
                })
            }
        }
        // 编辑笔记
        .sheet(isPresented: $showEditNoteView, content: {
            NewNoteView(noteModel: noteModel)
        })
        // 删除笔记
        .actionSheet(isPresented: $showingActionSheet) {
            return ActionSheet(
                title: Text("你确定要删除此项吗？"),
                message: nil,
                buttons: [
                    .destructive(Text("删除"), action: {
                        self.viewModel.deleteItem(item: noteModel)
                    }),
                    .cancel(Text("取消")),
                ])
        }
    }
}

#Preview {
    ContentView().environmentObject(NoteViewModel())
}
