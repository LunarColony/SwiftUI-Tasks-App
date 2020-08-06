//
//  AppView.swift
//  SimpleToDoList
//
//  Created by Yunis Farah on 04/08/2020.
//  Copyright © 2020 LunarColony. All rights reserved.
//

import SwiftUI

struct AppView: View {

    var body: some View {
        TaskListView(taskArray: ["Add a new task below ↓"], NewTask: "")
    }
}


struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

struct TaskListView: View {
    @State var taskArray = [String]()
    @State var NewTask: String

    var body: some View {
        NavigationView {
            VStack {
                Section {
                    List(taskArray, id: \.self) { value in
                        Section {
                            Text(value)
                        }
                    }
                    HStack {
                        TextField("Add new task", text: $NewTask)
                            .padding()
                        Button("Save") {
                            if self.taskArray.contains("Add a new task below ↓") {
                                self.taskArray.remove(at: 0)
                            }
                            if self.NewTask.count > 0 {
                                self.taskArray.append(self.NewTask)
                                print(self.taskArray.count)
                            }
                        }
                            .padding()
                    }

                }


                    .animation(.default)
                    .listStyle(GroupedListStyle())
                    .environment(\.horizontalSizeClass, .regular)

                    .navigationBarTitle("Tasks")
            }

        }
    }

    private func deleteItem(at indexSet: IndexSet) {
        self.taskArray.remove(atOffsets: indexSet)
    }

}
