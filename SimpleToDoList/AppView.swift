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
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(data.arrayOfTask, id: \.self) { row in
                        Text("\(row)")
                    }
                        .onDelete(perform: removeItems).animation(.default)
                }
                    .listStyle(GroupedListStyle())
                    .environment(\.horizontalSizeClass, .regular)
            }
                .navigationBarTitle("Tasks")
                .navigationBarItems(trailing: Button(action: {
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
    @State var newCatergory = ""
    @State var newPriorityLevel = ""


    @Binding var showViewTwo: Bool
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Add task information here")) {
                    VStack {
                        Section {
                            TextField("Name", text: $newName)
                        }
                        /*
                         This section will be implementated later on
                         
                        Section {
                            TextField("Catergory", text: $newCatergory)
                        }
                        Section {
                            TextField("Priority", text: $newPriorityLevel)
                        }
                         */
                    }
                }
            }
                .navigationBarTitle("New task details")
                .navigationBarItems(trailing:
                        Button("Save") {
                            self.showViewTwo.toggle()
                            self.data.taskName = self.newName
                            self.data.arrayOfTask.append(self.newName)
                    })
        }
    }
}


