import SwiftUI

struct GroupView: View {
    @Binding var changeLan : Int
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var projectViewModel: ProjectViewModel
    var body: some View {
        //hhhhh
        ZStack(alignment: .top){//
            ScrollView {//
                VStack{
                    Color.clear.frame(height: 50)
                    if projectViewModel.projects.isEmpty{
                        Text("Not yet")
                    }else{
                        ForEach(0 ..< projectViewModel.projects.count, id: \Int.self) { Index in
                            
                            //let project = projectViewModel.projects[Index]
                            let project = projectViewModel.projects[Index]
                            GroupRowView(changeLan: $changeLan, project: project,  ondelete: {
                                self.projectViewModel.DeleteProject(IndexSet: Index)
                                
                            })
                            .onTapGesture {
                                withAnimation(.linear) {
                                    projectViewModel.updateproject(project: project)
                                }
                            }
                            .padding(.bottom)
                        }
                    }
                }.padding()
                
            }
            ZStack{
                Rectangle()
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .frame(height: 50)
                VStack{
                    HStack{
                        Text(changeLan == 1 ? "Group" : "群组")
                            .font(.system(size: 18, weight: .heavy))
                            .foregroundColor(.gray)
                        Spacer()
                    }.padding(.horizontal)
                        .padding(.top)
                    Divider()
                    
                }
            }
            
        }
        
    }
}

