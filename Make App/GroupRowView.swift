import SwiftUI

struct GroupRowView: View {
    @Binding var changeLan : Int
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.colorScheme) var colorScheme
    @State var showinfosheet = false
    @State var showsettingView = false
    let project : ProjectModel
    
    let ondelete : ()->()
    var body: some View {
        Button{
            
        }label: {
        VStack{
            HStack{
            Text(project.title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.blue)
                Spacer()
                Image(systemName: "chevron.forward")
                    .font(.system(size: 18, weight: .bold))
            }
            Divider()
            HStack{
                Text(project.createtime, style: .date)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
                Spacer()
                Text(project.createtime, style: .time)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
            }
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18,style: .continuous)
                .fill(colorScheme == .dark ? Color(red: 0.12, green: 0.12, blue: 0.12) : Color.white)
                .shadow(color: .gray.opacity(0.13) , radius: 10, x: 0, y: 5)
        )
    }
        .contextMenu {
            Button(role: .destructive){
                self.ondelete()
            }label: {
                Text(changeLan == 1 ? "Delete" : "删除")
                Image(systemName: "delete.left")
            }
        }
    }
}
