//
//  AddLesson.swift
//  learningGPT
//
//  Created by Łukasz Muszyński on 23/02/2023.
//

import SwiftUI
import CoreData

struct AddLesson: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var content = ""
    @State private var subject = ""
    @State private var reminderDate = Date()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Content")) {
                    TextEditor(text: $content)
                }
                
                Section(header: Text("Subject")) {
                    TextField("Subject", text: $subject)
                }
                
                Section(header: Text("Reminder Date")) {
                    DatePicker("Select a date", selection: $reminderDate, displayedComponents: [.date, .hourAndMinute])
                }
            }
            .navigationTitle("Add Learning Object")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        addLearningObject()
                    }
                }
            }
        }
    }
    
    private func addLearningObject() {
        withAnimation {
            let newLearningObject = LearningObject(context: viewContext)
            newLearningObject.addDate = Date()
            newLearningObject.modificationDate = Date()
            newLearningObject.content = content
            newLearningObject.subject = subject
            newLearningObject.reminderDate = reminderDate
            newLearningObject.status = "New"
            
            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


struct AddLesson_Previews: PreviewProvider {
    static var previews: some View {
        AddLesson()
    }
}
