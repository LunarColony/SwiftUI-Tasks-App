//
//  AppView.swift
//  SimpleToDoList
//
//  Created by Yunis Farah on 04/08/2020.
//  Copyright © 2020 LunarColony. All rights reserved.
//

import SwiftUI

struct AppView: View {
    let selectedCatergory = DataModel()
    var body: some View {
        NavigationView {
            VStack {
                Section {
                    Text("\(selectedCatergory.catergoryName)")
                    //Text("")
                }
                Spacer()
                createNewListButton()
            }

            // Modifiers for NavigationView
            .navigationBarTitle("Todo Lists")
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

struct createNewListButton: View {
    @State var showFormSheet = false
    var body: some View {
        withAnimation {
            Button(action: {
                self.showFormSheet.toggle()
            }) {
                ZStack {
                    Rectangle()
                        .cornerRadius(20)
                        .frame(width: 340, height: 50)
                        .foregroundColor(Color.green)
                    Text("Create New list")
                        .foregroundColor(Color.white)
                }
            }.sheet(isPresented: $showFormSheet) {
                newListFormView(isPresented: self.$showFormSheet)
            }
        }
            .animation(.default)
    }
}

struct newListFormView: View {
    @ObservedObject var catergory = DataModel()
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Catergory", text: $catergory.catergoryName)
                    }
                }
                    .listStyle(GroupedListStyle())
                    .environment(\.horizontalSizeClass, .regular)
            }
                .navigationBarTitle("Create new list")
                .navigationBarItems(trailing: Button(action: {
                        self.isPresented.toggle()
                        // For debugging 
                        print("\(self.catergory.catergoryName)")
                }) {
                        Text("Done")
                    }
                )
        }
    }

}



/*
struct newListViewContainer: View {
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(10)
                .frame(width: 360, height: 60)
                .foregroundColor(Color.init(red: 255, green: 81, blue: 81))
                .shadow(radius: 3)

            HStack {
                Text("Holiday Essentials")
                    .padding()
                Spacer()

            }
                .padding(.leading, 30.0)
        }
    }
}
*/

