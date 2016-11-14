//
//  main.swift
//  Visitor
//
//  Created by Peikang Hu on 10/15/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

let shapes = ShapeCollection()

let areaVisitor = AreaVisitor()
shapes.accept(visitor: areaVisitor)
print("Area: \(areaVisitor.totalArea)")

print("---")

let edgeVisitor = EdgesVisitor()
shapes.accept(visitor: edgeVisitor)
print("Edges: \(edgeVisitor.totalEdges)")
