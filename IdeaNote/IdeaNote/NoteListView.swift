//
//  NoteListView.swift
//  IdeaNote
//
//  Created by DongQing on 2023/11/14.
//

import SwiftUI

struct NoteListView: View {
    @State var noteItems: [NoteItem] = [NoteItem(writeTime: "2022.09.17", title: "第一条笔记", content: "快来使用念头笔记记录生活吧～快来使用念头笔记记录生活吧～")]
    var body: some View {
        List {
            ForEach(noteItems) { noteItem in
                NoteListRow(noteItem: noteItem)
            }
        }
        .listStyle(InsetListStyle())
    }
}


struct NoteListRow: View {
    
    @ObservedObject var noteItem: NoteItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(noteItem.writeTime)
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                Text(noteItem.title)
                    .font(.system(size: 17))
                    .foregroundStyle(.black)
                Text(noteItem.content)
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            
            Button(action: {
                
            }, label: {
                Image(systemName: "ellipsis")
                    .foregroundStyle(.gray)
                    .font(.system(size: 23))
            })
        }
    }
}

#Preview {
    NoteListView()
}
