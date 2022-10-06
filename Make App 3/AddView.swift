import SwiftUI

struct AddView: View {
    @Binding var openView : Bool
    //let addproject = ProjectModel(title: String(), createtime: Date(), itemModel: ItemModel())
    @Binding var deleteBool : Bool
    @Binding var changeLan : Int
    // MARK: PROPERTIES
    @Environment(\.presentationMode) var mode
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    //说说今天发生的事情吧...
    @State var textFieldText: String = ""
    @State var FieldText_sec: String = ""
    @AppStorage("Third_TextField") var FieldText_thi: String = ""
    @AppStorage("copy_TextField") var FieldText_copy: String = ""
    @AppStorage("mood_Key") var timemoodInt : Int = 1
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: BODY
    
    var body: some View {
        
        ZStack{
            ScrollView {
                VStack (alignment: .leading){
                    
                    VStack{
                        HStack{
                        TextField(changeLan == 1 ? "Project Name":"项目名称", text: $textFieldText)
                                .foregroundColor(.blue)
                            .font(.system(size: 30, weight: .heavy))
                            Button{
                                deletenametext()
                            }label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        Divider()
                        HStack{
                        TextField(changeLan == 1 ? "Project Note":"备注", text: $FieldText_sec)
                                .foregroundColor(.accentColor)
                                .opacity(0.7)
                                .font(.system(size: 18, weight: .bold))
                            
                        }
                        /*TextField("Type something here...", text: $textFieldText)
                         .padding(.horizontal)
                         .frame(height: 55)
                         .background(.clear)
                         .cornerRadius(10)
                         .shadow(color: .secondary.opacity(0.2), radius: 15, x: 0, y: 8)*/
                    }.padding()
                        .background(
                            RoundedRectangle(cornerRadius: 18,style: .continuous)
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .shadow(color: .gray.opacity(0.18) , radius: 10, x: 0, y: 5)
                        )
                    /*HStack{
                        Text(changeLan == 1 ? "*It will be automatically saved as a draft and can be viewed next time you open it":"*将会自动保存为草稿，下次打开即可查看")
                            .font(.system(size: 11))
                            .foregroundColor(Color(red: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/, green: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/, blue: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/))
                            .padding()
                        Spacer()
                    }*/
                }
                .padding(14)
                
            }
            .alert(isPresented: $showAlert, content: getAlert)
            VStack{
                Spacer()
                HStack{
                    Button{
                        mode.wrappedValue.dismiss()
                    }label: {
                        Text(changeLan == 1 ? "Back":"返回")
                            .foregroundColor(.gray)
                            .font(.headline)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 18,style: .continuous)
                                    .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                                    .shadow(color: .gray.opacity(0.18) , radius: 10, x: 0, y: 5)
                            )
                            .padding(.top)
                    }
                    Spacer()
                    Button(action: saveButtonPressed, label: {
                        HStack{
                        Text(changeLan == 1 ? "Save":"保存".uppercased())
                            .foregroundColor(.white)
                            .font(.headline)
                            Image(systemName: "tray.and.arrow.down")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 18,style: .continuous)
                                    .foregroundColor(.accentColor)
                                    .shadow(color: .accentColor.opacity(0.3) , radius: 10, x: 0, y: 5)
                            )
                            .padding(.top)
                    })
                }.padding()
            }
        }.navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
    // MARK: FUNCTIONS
    
    func saveButtonPressed() {
        if textIsAppropriate() {
        listViewModel.addItem(title: textFieldText, timemood: timemoodInt, funtitle: FieldText_sec, verytitle: FieldText_thi, copytitle: FieldText_copy, delete: deleteBool, groupTitle: groupTitle, groupCreateTime: groupTime, open: openView)
        presentationMode.wrappedValue.dismiss()
        }
    }
    func deletenametext(){
        textFieldText = ""
    }
    func textIsAppropriate() -> Bool {
        if textFieldText == "" {
            alertTitle = "你没有输入项目名称哦😯\n快去看看吧！"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
    @State var groupTitle = ""
    @State var groupTime = Date()
}

