//
//  TwoWayAdapter.swift
//  Adapter
//
//  Created by Peikang Hu on 10/2/16.
//  Copyright © 2016 Peikang Hu. All rights reserved.
//

import Foundation

class Main
{
    class func main()
    {
        let adapter = TwoWayAdapter()
        let component = SketchComponent(settings: adapter)
        let app = DrawingApp(drawer: adapter)
        
        adapter.app = app
        adapter.component = component
        
        app.makePicture()
    }
}

// Application
protocol ShapeDrawer
{
    func drawShape()
}

class DrawingApp
{
    let drawer:ShapeDrawer
    
    var conrnerRadius:Int = 0
    
    init(drawer:ShapeDrawer)
    {
        self.drawer = drawer
    }
    
    func makePicture()
    {
        drawer.drawShape()
    }
}

// Component Library
protocol AppSettings
{
    var sketchRoundedShapes:Bool { get }
}

class SketchComponent
{
    private let settings:AppSettings
    
    init(settings:AppSettings)
    {
        self.settings = settings
    }
    
    func sketchShape()
    {
        if (settings.sketchRoundedShapes)
        {
            print("Sketch Circle")
        }
        else
        {
            print("Sketch Square")
        }
    }
}

class TwoWayAdapter: ShapeDrawer, AppSettings
{
    var app: DrawingApp?
    var component:SketchComponent?
    
    func drawShape() {
        component?.sketchShape()
    }
    
    var sketchRoundedShapes: Bool
    {
        return (app?.conrnerRadius)! > 0
    }
}

