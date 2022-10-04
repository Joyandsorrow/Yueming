import SwiftUI



class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey: String = "items_list"
    
    init() {//保存声明
        getItems()
    }
    
    func getItems() {//保存中转
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func Delete(IndexSet: Int){
        items.remove(at: IndexSet)
        self.saveItems()
    }
    
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String, timemood: Int, funtitle: String, verytitle: String, copytitle: String, delete: Bool, projectModel: ProjectModel, groupTitle: String, groupCreateTime: Date) {
        let newItem = ItemModel(title: title, isCompleted: false, createTime: Date(), timemood: timemood, funtitle: funtitle, verytitle: verytitle, copytitle: copytitle, delete: delete, projectModel: projectModel, groupTitle: groupTitle, groupCreateTime: groupCreateTime)
        items.append(newItem)
    }
    
    
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems() {//保存方法
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    
    
    
    
}
