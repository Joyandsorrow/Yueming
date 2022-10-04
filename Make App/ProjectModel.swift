import SwiftUI

class ProjectViewModel: ObservableObject {//
    @Published var projects: [ProjectModel] = [] {
        didSet {
            saveproject()
        }
    }
    
    init() {//保存声明
        getprojects()
    }
    
    let projectsKey: String = "projects_list"
    
    func getprojects() {//保存中转
        guard
            let data = UserDefaults.standard.data(forKey: projectsKey),
            let savedproject = try? JSONDecoder().decode([ProjectModel].self, from: data)
        else { return }
        
        self.projects = savedproject
    }
    
    func DeleteProject(IndexSet: Int){
        projects.remove(at: IndexSet)
        self.saveproject()
    }
    
    func addproject(title: String, createtime: Date) {
        let newItem = ProjectModel(title: title, createtime: createtime)
        projects.append(newItem)
    }
    
    func updateproject(project: ProjectModel) {
        if let index = projects.firstIndex(where: { $0.id == project.id }) {
            projects[index] = project.updateCompletionp()
        }
    }
    
    func saveproject() {//保存方法
        if let encodedData = try? JSONEncoder().encode(projects) {
            UserDefaults.standard.set(encodedData, forKey: projectsKey)
        }
    }
}
 
