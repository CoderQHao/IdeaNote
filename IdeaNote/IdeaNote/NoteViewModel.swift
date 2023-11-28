//
//  NoteViewModel.swift
//  IdeaNote
//
//  Created by DongQing on 2023/11/19.
//

import Combine
import Foundation
import SwiftUI

class NoteViewModel: ObservableObject {

    @Published var noteModels = [NoteModel]()
    
    // 笔记参数
    @Published var writeTime: String = ""
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var searchText = ""

    // 是否正在搜索
    @Published var isSearching: Bool = false
    
    // 是否是新增
    @Published var isAdd: Bool = true
    
    // 打开新建笔记弹窗
    @Published var showNewNoteView: Bool = false
    
    // 提示信息
    @Published var showToast = false
    @Published var showToastMessage: String = "提示信息"
    
    init() {
        loadItems()
    }
    
    // 创建笔记
    func addItem(writeTime: String, title: String, content: String) {
        let newItem = NoteModel(writeTime: writeTime, title: title, content: content)
        noteModels.append(newItem)
        saveItems()
    }
    
    // 获得数据
    func getItemById(noteId: UUID) -> NoteModel? {
        return noteModels.first(where: { $0.id == noteId }) ?? nil
    }

    // 删除笔记
    func deleteItem(item: NoteModel) {
        noteModels.removeAll(where: { $0.id == item.id })
        saveItems()
    }

    // 编辑笔记
    func editItem(item: NoteModel) {
        if let index = noteModels.firstIndex(where: { $0.id == item.id }) {
            noteModels[index] = item
            saveItems()
        }
    }
    
    // 通过标题搜索笔记
    func searchContet() {
        let query = searchText.lowercased()
        DispatchQueue.global(qos: .background).async {
            let filter = self.noteModels.filter { $0.content.lowercased().contains(query) }
            DispatchQueue.main.async {
                self.noteModels = filter
            }
        }
    }
    
    func getCurrentTime() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM.dd HH:mm"
        return dateformatter.string(from: Date())
    }

    func dataFilePath() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("IdeaNote.plist")
    }

    // 将数据写入本地存储
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(noteModels)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error writing items to file: (error.localizedDescription)")
        }
    }

    // 从本地存储加载数据
    func loadItems() {
        let path = dataFilePath()

        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                noteModels = try decoder.decode([NoteModel].self, from: data)
            } catch {
                print("Error reading items: (error.localizedDescription)")
            }
        }
    }
}
