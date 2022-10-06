import SwiftUI

//主页面
struct ListView: View {
    @State var openView = false
    //@State var viewprojectmakeName : String
    @State var DisplayWidth: CGFloat = 0
    @State var DisplayHeight: CGFloat = 0
    @State var DisplaywidthAndHeight = ""
    
    @AppStorage("deleteBool_Key") var deleteBool = false
    @AppStorage("add_view_show_key") var addnewviewShow = false
    @State var popsheet = false
    @State var settingsheet = false
    @State var showStatusBar = true
    @State var todo = false
    @EnvironmentObject var listViewModel: ListViewModel
    @EnvironmentObject var projectViewModel: ProjectViewModel
    //@EnvironmentObject var projectViewModel: ProjectViewModel
    @Environment(\.colorScheme) var colorScheme
    let columnCount: Int = 4
    let gridSpacing: CGFloat = 16.0
    @State var vvvvv = false
    
    @Environment(\.horizontalSizeClass) var horizontalClass
    /*
     let columnCount: Int = 2
     let gridSpacing: CGFloat = 16.0
     
     ScrollView(.vertical) {
     LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: gridSpacing), count: columnCount), spacing: gridSpacing) {
     gridImages
     }
     }
     */
    @AppStorage("openone_Key") var openone = true
    var body: some View {
        ZStack{
        ZStack {
            Button{
                showStatusBar.toggle()
            }label: {
                Text("_")
                    .foregroundColor(.clear)
            }.statusBar(hidden: showStatusBar)
            if listViewModel.items.isEmpty {
                NoItemsView(openView: $openView, changeLan: $changeLan, deleteBool: $deleteBool)
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    Color.clear
                        .frame(width: .infinity, height: 180)
                    if horizontalClass == .regular{
                        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: gridSpacing), count: columnCount), spacing: gridSpacing) {
                            //ForEach(listViewModel.items) { item in
                            
                                ForEach(0 ..< listViewModel.items.count, id: \Int.self) { Index in
                                    
                                    //let project = projectViewModel.projects[Index]
                                    let item = listViewModel.items[Index]
                                    ListRowView(openView: $openView, DisplayWidth: $DisplayWidth, DisplayHeight: $DisplayHeight,DisplaywidthAndHeight: $DisplaywidthAndHeight ,changeLan: $changeLan, item: item,  ondelete: {
                                    self.listViewModel.Delete(IndexSet: Index)
                                        }
                                                
                                    ).id(Index)
                                    .onTapGesture {
                                        withAnimation(.linear) {
                                            listViewModel.updateItem(item: item)
                                        }
                                    }
                                    .padding(.bottom)
                                //}//link
                            }
                        }.padding()
                    }else{
                        
                        
                        VStack{
                            ForEach(0 ..< listViewModel.items.count, id: \Int.self) { Index in
                                let item = listViewModel.items[Index]
                                
                                ListRowView(openView: $openView, DisplayWidth: $DisplayWidth, DisplayHeight: $DisplayHeight,DisplaywidthAndHeight: $DisplaywidthAndHeight , changeLan: $changeLan, item: item,ondelete: {
                                    
                                    //self.listViewModel.deleteItem(indexSet: )
                                    self.listViewModel.Delete(IndexSet: Index)//
                                    
                                }).id(Index)
                                    .onTapGesture {
                                        withAnimation(.linear) {
                                            listViewModel.updateItem(item: item)
                                        }
                                    }
                                    .padding(.bottom)
                                //}
                            }
                            
                            //.onDelete(perform: listViewModel.deleteItem)
                            //.onMove(perform: listViewModel.moveItem)
                        }.padding()
                    }
                }
                
            }
            VStack{
                Spacer()
                HStack{
                    Spacer()
                        Button{
                            addnewviewShow.toggle()
                        }label: {
                        HStack{
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: 30, weight: .heavy, design: .monospaced))
                        }
                        .shadow(color: .white.opacity(0.8), radius: 5, x: 0, y: 3)
                        .padding(20)
                        .background(
                            Circle()
                                .foregroundColor(.accentColor)
                                .shadow(color: .accentColor.opacity(0.3), radius: 15, x: 0, y: 3)
                        )
                        .padding()
                    }.sheet(isPresented: $addnewviewShow, content: {
                        AddView(openView: $openView, deleteBool: $deleteBool, changeLan: $changeLan)
                    })
                }
            }
            VStack{
                ZStack(alignment: .bottom){
                    ZStack(alignment: .topTrailing){
                        VStack{
                            //Color(red: 0, green: 0.77, blue: 0.7)
                            Color.accentColor
                                .frame(width: .infinity, height: 180)
                                .shadow(color: .accentColor.opacity(0.4), radius: 15, x: 0, y: 3)
                                .ignoresSafeArea()
                            
                                
                        }
                        HStack{
                            Button{
                                popsheet.toggle()
                            }label: {
                                Image(systemName: "questionmark.circle.fill")
                                    .font(.system(size: 25, weight: .semibold, design: .default))
                                    .foregroundColor(.white)
                                /*Image("?image")
                                    .resizable()
                                    .frame(width: 38, height: 38)
                                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 3)*/
                            }.sheet(isPresented: $popsheet, content: {
                                
                            })
                            Button{
                                settingsheet.toggle()
                            }label: {
                                Image(systemName: "gearshape.fill")
                                .font(.system(size: 25, weight: .semibold, design: .default))
                                .foregroundColor(.white)
                                /*
                                 Image("Settingimage")
                                 .resizable()
                                 .frame(width: 40, height: 40)
                                 .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 3)
                                 */
                                
                            }.sheet(isPresented: $settingsheet, content: {
                                settingView
                            })
                        }.padding(20)
                    }
                    HStack{
                        VStack(alignment: .leading){
                            /*
                            Image("DayCardText")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 220, height: .infinity)
                                .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 3)*/
                            
                            Text("App Studio")
                                .bold()
                                .font(.system(size: 40, weight: .black, design: .default))
                                .foregroundColor(.white)
                            Text("Happiness is the most important thing in life.")
                                .font(.system(size: 15, weight: .semibold, design: .default))
                                .foregroundColor(.white)
                            
                        }.padding()
                        Spacer()
                    }
                }
                Spacer()
            }
            
        }
        .overlay(GeometryReader { geo -> AnyView in
            DispatchQueue.main.async{
                DisplayWidth = geo.size.width
                DisplayHeight = geo.size.height
                DisplaywidthAndHeight = geo.size.debugDescription
            }
            return AnyView(EmptyView())
        })
        /*.navigationBarItems(
         leading: EditButton(),
         //trailing:
         
         )*/
        .navigationBarTitleDisplayMode(.inline)
            if openView{
                make_phone(openView: $openView, changeLan: $changeLan)
                    .environmentObject(projectViewModel)
                //.environmentObject(ProjectViewModel.init(key: item.title))
            }
        }
    }
    @AppStorage("ChangeLan_Kay") var changeLan = 2
    @State var showabwe : Bool = false
    @State var showwe : Bool = false
    var settingView : some View{
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading){
                Text(changeLan == 1 ? "Setting" : "设置")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 30, weight: .bold))
                    .shadow(color: .accentColor.opacity(0.3) , radius: 10, x: 0, y: 5)
                HStack{
                    Text(changeLan == 1 ? "language":"语言")
                        .foregroundColor(.accentColor)
                        .bold()
                    Spacer()
                    Picker(selection: $changeLan, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                        Text("中文")
                            .tag(2)
                        Text("English")
                            .tag(1)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 18,style: .continuous)
                        .fill(colorScheme == .dark ? Color(red: 0.12, green: 0.12, blue: 0.12) : Color.white)
                        .shadow(color: .gray.opacity(0.13) , radius: 10, x: 0, y: 5)
                )
                Button{
                    withAnimation(.easeInOut){
                        showabwe.toggle()
                    }
                }label: {
                    HStack{
                        Text(changeLan == 1 ? "About we":"关于我们")
                            .foregroundColor(.accentColor)
                            .bold()
                        Spacer()
                        if showabwe{
                            Image(systemName: "chevron.down")
                                .foregroundColor(.accentColor)
                        }else{
                            Image(systemName: "chevron.right")
                                .foregroundColor(.accentColor)
                        }
                    } .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 18,style: .continuous)
                                .fill(colorScheme == .dark ? Color(red: 0.12, green: 0.12, blue: 0.12) : Color.white)
                                .shadow(color: .gray.opacity(0.13) , radius: 10, x: 0, y: 5)
                        )
                }//Button
                if showabwe {
                    VStack{
                        HStack{
                            Text(changeLan == 1 ? "Developers and designers":"开发／设计人员")
                                .foregroundColor(.gray)
                                .bold()
                            Spacer()
                            Text(changeLan == 1 ? "Yueming" : "园津·中竹")
                                .bold()
                                .foregroundColor(.accentColor)
                        }
                        Divider()
                        HStack{
                            Text(changeLan == 1 ? "My contact information":"开发者联系方式")
                            
                                .foregroundColor(.gray)
                                .bold()
                            Spacer()
                            
                        }.padding(.bottom,1)
                        HStack{
                            Text(changeLan == 1 ? "YuemingWay (WeChat)" : "YuemingWay"+"(微信)")
                                .bold()
                                .foregroundColor(.accentColor)
                            Spacer()
                        }
                        HStack{
                            Text("1516057969 (QQ)")
                                .bold()
                                .foregroundColor(.accentColor)
                            Spacer()
                        }
                        HStack{
                            Text("@yuanlinzhongzhu (Twitter)")
                                .bold()
                                .foregroundColor(.accentColor)
                            Spacer()
                        }
                        
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 18,style: .continuous)
                            .fill(colorScheme == .dark ? Color(red: 0.12, green: 0.12, blue: 0.12) : Color.white)
                            .shadow(color: .gray.opacity(0.13) , radius: 10, x: 0, y: 5)
                    )
                    
                }
                Button{
                    withAnimation(.easeInOut){
                        showwe.toggle()
                    }
                }label: {
                    HStack{//HStack
                        Text(changeLan == 1 ? "About this App (Chinese)":"关于应用")
                            .foregroundColor(.accentColor)
                            .bold()
                        Spacer()
                        if showwe{
                            Image(systemName: "chevron.down")
                                .foregroundColor(.accentColor)
                        }else{
                            Image(systemName: "chevron.right")
                                .foregroundColor(.accentColor)
                        }
                    } .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 18,style: .continuous)
                                .fill(colorScheme == .dark ? Color(red: 0.12, green: 0.12, blue: 0.12) : Color.white)
                                .shadow(color: .gray.opacity(0.13) , radius: 10, x: 0, y: 5)
                        )
                    
                }//Button
                if showwe{
                    VStack(alignment: .leading){
                        HStack{
                            Text("更新日志")
                                .foregroundColor(.accentColor)
                                .bold()
                            Spacer()
                        }.padding(.bottom,1)
                        HStack{
                            Text("2022.9.12")
                                .foregroundColor(.gray)
                                .bold()
                            Spacer()
                            Text("完成本应用1.0版本")
                                .foregroundColor(.gray)
                                .bold()
                        }.padding(.bottom,1)
                        
                        HStack{
                            Text("预计1.0.1版本")
                                .foregroundColor(.gray)
                                .font(.callout)
                                .bold()
                            Spacer()
                            Text("输击音效，更多功能...")
                                .foregroundColor(.gray)
                                .bold()
                        }
                        
                        
                    }.padding()
                        .background(
                            RoundedRectangle(cornerRadius: 18,style: .continuous)
                                .fill(colorScheme == .dark ? Color(red: 0.12, green: 0.12, blue: 0.12) : Color.white)
                                .shadow(color: .gray.opacity(0.13) , radius: 10, x: 0, y: 5)
                        )
                    
                }//if
                HStack{//
                    
                    Text("官方讨论QQ群")
                        .foregroundColor(.gray)
                        .bold()
                    Spacer()
                    Text("247533868")
                        .foregroundColor(.accentColor)
                        .bold()
                    
                }.padding()
                    .background(
                        RoundedRectangle(cornerRadius: 18,style: .continuous)
                            .fill(colorScheme == .dark ? Color(red: 0.12, green: 0.12, blue: 0.12) : Color.white)
                            .shadow(color: .gray.opacity(0.13) , radius: 10, x: 0, y: 5)
                    )
            }.padding()
        }
    }
    
}

