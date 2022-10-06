import SwiftUI

struct NoItemsView: View {
    @Binding var openView : Bool
    @AppStorage("add_view_show_key") var addnewviewShow = false
    @Binding var changeLan : Int
    @Binding var deleteBool: Bool
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    
    var body: some View {
        //ScrollView {
        VStack(spacing: 10) {
            Text(changeLan == 1 ? "Add your new project":"创建你的项目")
            //.foregroundColor(.black)
                .font(.system(size: 25, weight: .heavy, design: .default))
            
            
            Text(changeLan == 1 ? "📝Record the things and mood of the day！\n🗒We will save your card\n🔍You can also check it at any time！"
                 :
                    "📝记录下一天的事情和心情吧！\n🗒我们会保存好你的卡片\n🔍你也可以随时查看哦！！！")
            .foregroundColor(.gray)
            .padding(.bottom, 20)
            Button{
                addnewviewShow.toggle()
            }label: {
                HStack{
                    Text(changeLan == 1 ? "Add Now":"现在创建")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(animate ? secondaryAccentColor : .accentColor)
                        .cornerRadius(10)
                        .padding()
            }
            .padding(.horizontal, animate ? 30 : 50)
            .shadow(
                color: animate ? secondaryAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                radius: animate ? 40 : 20,
                x: 0,
                y: animate ? 1 : 0)
            .scaleEffect(animate ? 1.1 : 1.0)
            .offset(y: animate ? -4 : 0)
        }
        .frame(maxWidth: 400)
        .multilineTextAlignment(.center)
        .padding(40)
        .onAppear(perform: addAnimation)
        }
        .sheet(isPresented: $addnewviewShow, content: {
            AddView(openView: $openView, deleteBool: $deleteBool, changeLan: $changeLan)
        })
        //}
        
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
    
}
