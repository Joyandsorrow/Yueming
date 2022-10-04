import SwiftUI

struct make_phone: View {
    @State var groupCreateTime = Date()
    @StateObject var projectViewModel: ProjectViewModel = ProjectViewModel()
    @Environment(\.colorScheme) var colorScheme
    @Binding var opendetailView : Bool
    //let ondelete : ()->()
    @State private var showingAlert = false
    @State var showaddtitlegroup = false
    @Binding var changeLan : Int
    @AppStorage("groupTitle_key") var groupTitle = ""
    //@Environment(\.colorScheme) var colorScheme
    
    @State private var ViewWidth: CGFloat = 0
    @State private var ViewHeight: CGFloat = 0
    @State private var widthAndHeight = ""
    
    @State var scale: CGFloat = 1
    @State var add: CGFloat = 0
    
    @State private var ViewWidth1: CGFloat = 0
    @State private var ViewHeight1: CGFloat = 0
    @State private var widthAndHeight1 = ""
    
    @State private var ViewWidth3: CGFloat = 0
    @State private var ViewHeight3: CGFloat = 0
    @State private var widthAndHeight3 = ""
    
    @State private var iPhone13ProMaxWidth: CGFloat = 0
    @State private var iPhone13ProMaxHeight: CGFloat = 0
    @State private var iPhone13ProMaxwidthAndHeight = ""
    
    var body: some View {
        ZStack{
            ZStack{
                VStack{
                    Color.clear
                        .frame(height: ViewHeight)
                    ZStack{
                        RoundedRectangle(cornerRadius: 23, style: .continuous)
                            .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                            .frame(width: iPhone13ProMaxWidth-29, height: iPhone13ProMaxHeight-30)
                            .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 3)
                            .ignoresSafeArea(.keyboard, edges: .bottom)
                        //.frame(width: iPhone13ProMaxWidth, height: iPhone13ProMaxHeight)
                        Image("iPhone 13 Pro Max")
                            .resizable()
                            .scaledToFit()
                            .overlay(GeometryReader { geo -> AnyView in
                                DispatchQueue.main.async{
                                    iPhone13ProMaxWidth = geo.size.width
                                    iPhone13ProMaxHeight = geo.size.height
                                    iPhone13ProMaxwidthAndHeight = geo.size.debugDescription
                                }
                                return AnyView(EmptyView())
                            })
                            .ignoresSafeArea(.keyboard, edges: .bottom)
                    }
                    .padding(5)
                    .scaleEffect(scale + add)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { amount in
                                self.add = amount - 1
                            }
                            .onEnded { amount in
                                self.scale += self.add
                                self.add = 0
                            }
                    )
                    
                    Color.clear
                        .frame(height: ViewHeight3)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                }
                VStack{
                    HStack{
                        
                        Button{
                            
                        }label: {
                            Image(systemName: "square.stack")
                                .font(.system(size: 21, weight: .bold))
                                .shadow(color: .accentColor.opacity(0.3), radius: 10, x: 0, y: 2)
                        }
                        Button{
                            
                        }label: {
                            Image(systemName: "ellipsis.circle")
                                .font(.system(size: 23, weight: .bold))
                                .shadow(color: .accentColor.opacity(0.3), radius: 10, x: 0, y: 2)
                        }
                        Spacer()
                        Button{
                            showingAlert.toggle()
                        }label: {
                            Group{
                                Image(systemName: "chevron.right")
                            }
                            .font(.system(size: 25, weight: .heavy))
                            .shadow(color: .accentColor.opacity(0.3), radius: 10, x: 0, y: 2)
                        }.alert(isPresented: $showingAlert)//一种双向数据绑定，这是因为SwiftUI会在警报解除后自动将showingAlert设置为false
                        {
                            Alert(title:Text("退出"),
                                  message: Text("退出并保存项目"),
                                  primaryButton: .default(
                                    Text("取消"),
                                    action: {
                                        print("取消")
                                    }),
                                  secondaryButton: .destructive(
                                    Text("退出"),
                                    action: {
                                        opendetailView.toggle()
                                    }
                                  )
                                  
                            )//Alert
                            
                        }//alert
                    }.padding()
                        .background(
                            Rectangle()
                                .foregroundColor(colorScheme == .dark ? Color(red: 0.12, green: 0.12, blue: 0.12) : Color.white)
                                .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 2)
                                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        )
                    Spacer()
                    ZStack(alignment: .bottom){//
                        VStack{
                            ZStack(alignment: .top){//
                                ScrollView {//
                                    VStack{
                                        Color.clear.frame(height: 50)
                                        if projectViewModel.projects.isEmpty{
                                            Text(changeLan == 1 ?"There's nothing here" : "这里还空空如也")
                                                .font(.system(size: 24, weight: .heavy))
                                                .foregroundColor(.black)
                                            Text(changeLan == 1 ?"Add your first group! Start your work!":"创建你的新群组，以开始进行工作吧！")
                                                .bold()
                                                .foregroundColor(.gray)
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
                            
                                .frame(height: ViewHeight1/4.2)
                            //.environmentObject(projectViewModel)
                            Color.clear
                                .frame(height: ViewHeight-6)
                        }.background(
                            Rectangle()
                                .foregroundColor(colorScheme == .dark ? Color(red: 0.12, green: 0.12, blue: 0.12) : Color.white)
                                .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 2)
                                .overlay(GeometryReader { geo -> AnyView in
                                    DispatchQueue.main.async{
                                        ViewWidth3 = geo.size.width
                                        ViewHeight3 = geo.size.height
                                        widthAndHeight3 = geo.size.debugDescription
                                    }
                                    return AnyView(EmptyView())
                                })
                        )
                        HStack{//
                            
                            Button{
                                withAnimation(.easeInOut){
                                    showaddtitlegroup.toggle()
                                }
                            }label: {
                                HStack{
                                    Image(systemName: "plus")
                                        .font(.system(size: 24, weight: .bold))
                                        .shadow(color: .accentColor.opacity(0.3), radius: 10, x: 0, y: 2)
                                    Text(changeLan == 1 ? "Create Group" : "添加群组")
                                        .font(.system(size: 18, weight: .bold))
                                        .shadow(color: .accentColor.opacity(0.3), radius: 10, x: 0, y: 2)
                                }
                            }
                            
                            Spacer()
                            Button{
                                
                            }label: {
                                Group{
                                    Image(systemName: "iphone")
                                }
                                .font(.system(size: 25, weight: .medium))
                                .shadow(color: .accentColor.opacity(0.3), radius: 10, x: 0, y: 2)
                            }
                            
                        }.padding()
                            .background(
                                Rectangle()
                                    .overlay(GeometryReader { geo -> AnyView in
                                        DispatchQueue.main.async{
                                            ViewWidth = geo.size.width
                                            ViewHeight = geo.size.height
                                            widthAndHeight = geo.size.debugDescription
                                        }
                                        return AnyView(EmptyView())
                                    })
                                    .foregroundColor(colorScheme == .dark ? Color(red: 0.12, green: 0.12, blue: 0.12) : Color.white)
                                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 2)
                            )
                        //HStack
                    }
                }//VStack
                Color.clear
                    .edgesIgnoringSafeArea(.all)
                    .overlay(GeometryReader { geo -> AnyView in
                        DispatchQueue.main.async{
                            ViewWidth1 = geo.size.width
                            ViewHeight1 = geo.size.height
                            widthAndHeight1 = geo.size.debugDescription
                        }
                        return AnyView(EmptyView())
                    })
                
            }.ignoresSafeArea(.keyboard, edges: .bottom)
                .blur(radius: showaddtitlegroup == false ? 0 : 20)
                .onTapGesture {
                    withAnimation(.easeInOut){
                        showaddtitlegroup = false
                    }
                }
        if showaddtitlegroup{
            ZStack{
                VStack{
                    HStack{
                        TextField(changeLan == 1 ? "Group Title":"群组名称", text: $groupTitle)
                            .font(.system(size: 20, weight: .heavy))
                        Button{
                            groupTitle = ""
                        }label: {
                            if groupTitle == ""{
                                
                            }else{
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    Divider().padding(.top)
                    HStack{
                        Button{
                            withAnimation(.easeInOut){
                                showaddtitlegroup = false
                            }
                        }label: {
                            Text(changeLan == 1 ? "Cancel":"取消")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button{
                            withAnimation(.easeInOut){
                                showaddtitlegroup = false
                                addGroup()
                            }
                        }label: {
                            Text(changeLan == 1 ? "Create!":"创建")
                                .bold()
                                .foregroundColor(.white)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .foregroundColor(.blue)
                                        .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 3)
                                        .ignoresSafeArea(.keyboard, edges: .bottom)
                                )
                        }
                    }
                }
                .padding()
                    .frame(width: 320)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                            .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 3)
                            .ignoresSafeArea(.keyboard, edges: .bottom)
                    )
                    .padding()
            }
        }
        }
    }
    func addGroup(){
        projectViewModel.addproject(title: groupTitle, createtime: groupCreateTime)
    }
}


