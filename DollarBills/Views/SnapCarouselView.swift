//
//  SnapCarouselView.swift
//  DollarBills
//
//  Created by Febrian Daniel on 25/10/23.
//

import SwiftUI

struct SnapCarouselView <Content: View, T: Identifiable> : View {
    
    var content: (T) -> Content
    var list: [T]
    
    //Properties...
    var spacing: CGFloat
    var trailingSpace: CGFloat
    
    @Binding var index: Int
    
    init(spacing: CGFloat = 15, trailingSpace: CGFloat = 100, index: Binding<Int>, items : [T], @ViewBuilder content: @escaping(T)-> Content){
        
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
    }
    
    @GestureState var offset : CGFloat = 0
    @State var currentIndex : Int = 0
    
    var body: some View{
        GeometryReader { proxy in
            
            //One Sided Snap Carousel...
            let width = proxy.size.width - (trailingSpace - spacing)
            
            let adjustMentWidth = (trailingSpace/2) - spacing
            
            HStack (spacing: spacing){
                ForEach(list){item in
                    content(item)
                        .frame(width: proxy.size.width - trailingSpace)
                }
            }
            .padding(.horizontal, spacing)
            .offset(x: (CGFloat(currentIndex) * -width) + adjustMentWidth + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: {value, out, _index in
                        out = value.translation.width
                    })
                    .onEnded({ value in
                        //Updating Current Index
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        
                        //setting max..
                        currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 2), 0)
                        
                        //updating index...
                        currentIndex = index
                    })
                    .onChanged({ value in
                        //updating only index...
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        
                        //setting max..
                        index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        
                    })
            )
        }
        .animation(.easeInOut, value: offset == 0 )
    }
    
}

struct SnapCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        RoutesOfTheWeek(isRouteSelected: .constant(false), routes: CustomAnnotationAndRoute.customAnnotation[0])
    }
}

