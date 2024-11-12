//
//  MainViewModel.swift
//  ProgrammaticTableView-MVVM
//
//  Created by Bayram Yeleç on 12.11.2024.
//

import Foundation

class MainViewModel {
    
    var model: [Todo] = [] {
        didSet{
            saveTodo()
        }
    }
    
    init() {
        fetchTodo()
    }
    
    func addTodo(title: String){
        let todo = Todo(title: title)
        model.append(todo)
    }
    
    func deleteTodo(at index: Int){
        model.remove(at: index)
    }
    
    func toggleTodo(at index: Int){
        model[index].isTicked.toggle()
    }
    
    func saveTodo(){
        do {
            let todo = try JSONEncoder().encode(model)
            UserDefaults.standard.set(todo, forKey: "todos")
        } catch {
            print(error)
        }
    }
    
    func fetchTodo(){
        if let todos = UserDefaults.standard.data(forKey: "todos") {
            do {
                let todo = try JSONDecoder().decode([Todo].self, from: todos)
                self.model = todo
            } catch {
                print(error)
            }
        }
    }

    
}
