import SwiftUI

class ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let createTime: Date
    let isCompleted: Bool
    let timemood: Int
    let funtitle: String
    let verytitle: String
    let copytitle: String
    let delete: Bool
    var 项目编辑: [ProjectModel] = []
    var open : Bool
    
    let groupTitle : String
    let groupCreateTime : Date
    
    //let projectModel: ProjectModel
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool, createTime: Date, timemood: Int, funtitle: String, verytitle: String, copytitle: String , delete: Bool, groupTitle: String, groupCreateTime: Date, open : Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.createTime = createTime
        self.timemood = timemood
        self.funtitle = funtitle
        self.verytitle = verytitle
        self.copytitle = copytitle
        self.delete = delete
        self.groupCreateTime = groupCreateTime
        self.groupTitle = groupTitle
        self.open = open
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted, createTime: createTime, timemood: timemood, funtitle: funtitle, verytitle: verytitle, copytitle: copytitle, delete: !delete, groupTitle: groupTitle, 
                         groupCreateTime: groupCreateTime, open: !open)
    }
    
}



class ProjectModel: Identifiable, Codable {
    let id: String
    let title: String
    let createtime: Date
    
    
    init(id: String = UUID().uuidString, title: String, createtime: Date) {
        self.id = id
        self.title = title
        self.createtime = createtime
        
    }
    
    func updateCompletionp() -> ProjectModel {
        return ProjectModel(id: id, title: title, createtime: createtime)
    }
    
}
