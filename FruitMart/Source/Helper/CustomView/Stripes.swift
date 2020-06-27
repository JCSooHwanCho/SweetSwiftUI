//
//  Stripes.swift
//  FruitMart
//
//  Created by Joshua on 2020/06/27.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct Stripes: Shape {
    var stripes: Int = 30
    var insertion: Bool = true
    var ratio: CGFloat

    var animatableData: CGFloat {
        get { ratio }
        set { ratio = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let stripeWidth = rect.width / CGFloat(stripes)

        let rects = (0..<stripes).map { index -> CGRect in
            let xOffSet = CGFloat(index) * stripeWidth
            let adjustment = insertion ? 0 : (stripeWidth * (1 - ratio))
            return CGRect(
                x: xOffSet + adjustment,
                y: 0,
                width: stripeWidth * ratio,
                height: rect.height
            )
        }

        path.addRects(rects)
        return path
    }
}

extension Stripes: Hashable { }

struct Stripes_Previews: PreviewProvider {
    static var previews: some View {
        Stripes(ratio: 0.5)
    }
}
