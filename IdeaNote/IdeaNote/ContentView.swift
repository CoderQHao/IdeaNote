//
//  ContentView.swift
//  IdeaNote
//
//  Created by DongQing on 2023/11/14.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchText = ""
    
    @State var showNewNoteView = false
    
    @State var noteItems: [NoteItem] = [NoteItem(writeTime: "2022.09.17", title: "第一条笔记", content: "快来使用念头笔记记录生活吧～快来使用念头笔记记录生活吧～")]
    
    var body: some View {
        NavigationView {
            ZStack {
                if noteItems.isEmpty {
                    noDataView()
                } else {
                    VStack {
                        searchBarView()
                        NoteListView()
                    }
                }
                newBtnView()
            }
            .navigationTitle("笔记App")
            .navigationBarTitleDisplayMode(.inline)
        }.sheet(isPresented: $showNewNoteView, content: {
            NewNoteView(showNewNoteView: $showNewNoteView)
        })
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
                    self.showNewNoteView = true
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
        TextField("搜索内容", text: $searchText)
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
                    if searchText != "" {
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
            .padding(.horizontal, 10)
    }
}

#Preview {
    ContentView()
}
