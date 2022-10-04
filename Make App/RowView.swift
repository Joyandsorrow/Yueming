import SwiftUI



struct ListRowView: View {
    @State var showStatusBar = true
    @Binding var changeLan : Int
    @Environment(\.presentationMode) var modeee
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.colorScheme) var colorScheme
    @State var showinfosheet = false
    @State var showsettingView = false
    let item : ItemModel//
    @StateObject var projectViewModel: ProjectViewModel = ProjectViewModel()
    let ondelete : ()->()
    /*
     
     */
    @AppStorage("opendetailView_Key") var opendetailView = false
    var body : some View{
        ZStack{
            
            Button{
                withAnimation(.easeInOut){
                    opendetailView.toggle()
                }
            }label: {
                
                card
                
            }.fullScreenCover(isPresented: $opendetailView, content: {
                if horizontalSizeClass == .regular{
                    making_pad
                }else{
                        make_phone(opendetailView: $opendetailView, changeLan: $changeLan)
                            .environmentObject(projectViewModel)
                }
            })
            .contextMenu {
                Button{
                    
                }label: {
                    Text(changeLan == 1 ? "cancel" : "取消")
                    Image(systemName: "multiply")
                }
                Button{
                    opendetailView = true
                }label: {
                    Text(changeLan == 1 ? "Open Project" : "打开")
                    Image(systemName: "arrow.right")
                }
                
                Button(role: .destructive){
                    self.ondelete()
                }label: {
                    Text(changeLan == 1 ? "Delete" : "删除")
                    Image(systemName: "delete.left")
                }
                
            }
            /*Button{
                opendetailView.toggle()
            }label: {
                
                card
                
            }/*.fullScreenCover(isPresented: $opendetailView, content: {
                details
            })*/
            if opendetailView{
            details
            }*/
        }
        
    }
    
    var making_pad: some View {//
        ZStack{
            
        }
    }
    
    var card: some View {
        VStack{
            HStack {
                
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                    HStack(alignment: .lastTextBaseline){
                        HStack{
                            VStack(alignment: .leading){
                            Text(item.title)
                                .font(.system(size: 28, weight: .heavy, design: .default))
                                .foregroundColor(.accentColor)
                                .shadow(color: .accentColor.opacity(0.3) , radius: 10, x: 0, y: 5)
                                if item.funtitle == ""{
                                    
                                }else{
                                    Text(item.funtitle)
                                        .font(.system(size: 15, weight: .medium, design: .default))
                                        .foregroundColor(.accentColor)
                                        .lineLimit(1)
                                        .shadow(color: .accentColor.opacity(0.3) , radius: 10, x: 0, y: 5)
                                }
                            
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 18, weight: .bold, design: .default))
                                .opacity(0.4)
                            /*Text(item.createTime, style: .time)
                                .font(.system(size: 15, weight: .heavy, design: .default))
                                .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                                .shadow(color: .gray.opacity(0.3) , radius: 10, x: 0, y: 5)*/
                        }
                    }.padding(.bottom,1)
                        
                        //.padding(.bottom, 10)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 18,style: .continuous)
                            .foregroundColor(.accentColor)
                            .opacity(0.1)
                        //.foregroundColor(colorScheme == .dark ? Color(red: 0.12, green: 0.12, blue: 0.12) : Color.white)
                        .shadow(color: .gray.opacity(0.12) , radius: 10, x: 0, y: 5)
                    )
                    .padding(.top,10)
                    .padding(.leading,10)
                    VStack{
                        HStack{//
                            Text(item.createTime, style: .date)
                                .font(.system(size: 15, weight: .heavy, design: .default))
                                .foregroundColor(.gray)
                                .shadow(color: .gray.opacity(0.3) , radius: 10, x: 0, y: 5)
                            Spacer()
                            Text(item.createTime, style: .time)
                                .font(.system(size: 15, weight: .heavy, design: .default))
                                .foregroundColor(.gray)
                                .shadow(color: .gray.opacity(0.3) , radius: 10, x: 0, y: 5)
                        }
                    }.padding(.bottom)
                        .padding(.leading)
                }//.padding()
                Spacer()
                
            }
        }
        
        //.padding()
        .background(
            RoundedRectangle(cornerRadius: 18,style: .continuous)
                .fill(colorScheme == .dark ? Color(red: 0.12, green: 0.12, blue: 0.12) : Color.white)
                .shadow(color: .gray.opacity(0.13) , radius: 10, x: 0, y: 5)
        )
        
        
    }
    @AppStorage("font_key") var textfontreadsil : Double = 17
    
    
}
