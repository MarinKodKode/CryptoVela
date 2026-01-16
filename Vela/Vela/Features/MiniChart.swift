import Foundation
import SwiftUI

struct MiniChart : View {
    
    let data : [Double]
    let isPositive : Bool
    
    var body: some View {
        HStack (spacing : 3 ){
            ForEach(data.indices, id: \.self){ index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(
                        LinearGradient(
                            colors: [
                                isPositive ? Color(hex: "10b981").opacity(0.6) : Color(hex: "ef4444").opacity(0.6),
                                isPositive ? Color(hex: "10b981").opacity(0.2) : Color(hex: "ef4444").opacity(0.2)
                            ],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                    .frame(height: 40 * data[index])
                    .opacity(0.6)
            }
        }
    }
}

#Preview {
    
    let data : [Double] = [9.2, 0.4, 8.3, 6.5]
    let isPositive : Bool = true
    
    MiniChart(data: data, isPositive: isPositive)
}
