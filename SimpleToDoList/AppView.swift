//
//  AppView.swift
//  Tasks
//
//  Created by Yunis Farah on 04/08/2020.
//  Copyright © 2020 LunarColony. All rights reserved.
//

import SwiftUI

struct AppView: View {
    @ObservedObject var data = Model()
    @State var showViewTwo = false
    @State var categoryTypes = ["Home", "Work", "Personal", "Business"]
    
    var task = Model.Task()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(data.arrayOfTask) { task in
                        HStack {
                            if task.priority == 0 {
                                PriorityGreen()
                            } else if task.priority == 1 {
                                PriorityYellow()
                            } else if task.priority == 2 {
                                PriorityOrange()
                            } else if task.priority == 3 {
                                PriorityRed()
                            }
                            Text("\(task.taskName)")
                            Spacer()
                            Text("\(task.taskCategory)")
                                .foregroundColor(Color.gray)
                        }
                    }
                        .onDelete(perform: removeItems).animation(.default)
                }
                    .listStyle(GroupedListStyle())
                    .environment(\.horizontalSizeClass, .regular)
            }
                .navigationBarTitle("Tasks")
                .navigationBarItems(leading:
                        EditButton().animation(.default),
                    trailing: Button(action: {
                        self.showViewTwo.toggle()
                    }) {
                        Text("New task")
                    }.sheet(isPresented: $showViewTwo) {
                        ViewTwo(data: self.data, showViewTwo: self.$showViewTwo)
                    })
        }
    }



    func removeItems(at offset: IndexSet) {
        data.arrayOfTask.remove(atOffsets: offset)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

struct ViewTwo: View {
    @State var data: Model
    @State var newName = ""
    @State var newCategory = ""
    @State var newPriorityLevel = ""

    @State var defaultPriorityLevel = 1
    @State var priorityTypes = ["low", "medium", "high", "critical"]

    @State var defaultCategorySelection = 2
    @State var categoryTypes = ["Home", "Work", "Personal", "Business"]

    @Binding var showViewTwo: Bool
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Add task name")) {
                    TextField("Name", text: $newName)
                }
                Section(header: Text("Select task priority")) {
                    Picker("Priority Levels", selection: $defaultPriorityLevel) {
                        ForEach(0..<priorityTypes.count) {
                            Text(self.priorityTypes[$0])
                        }
                    }
                        .pickerStyle(SegmentedPickerStyle())
                }


                Section(header: Text("Select a category")) {
                    Picker("Catergories", selection: $defaultCategorySelection) {
                        ForEach(0..<categoryTypes.count) {
                            Text(self.categoryTypes[$0])
                        }
                    }
                        .pickerStyle(SegmentedPickerStyle())
                }
            }
                .navigationBarTitle("New task details")
                .navigationBarItems(trailing:
                        Button("Save") {
                            var task = Model.Task()
                            self.showViewTwo.toggle()
                            task.taskName = self.newName
                            task.priority = self.defaultPriorityLevel
                            task.taskCategory = self.categoryTypes[self.defaultCategorySelection]
                            self.data.arrayOfTask.append(task)
                    })
        }
    }
}

struct PriorityCirleView: View {
    var body: some View {
        Circle()
            .frame(width: 20, height: 20)
            .foregroundColor(Color.green)
    }
}


