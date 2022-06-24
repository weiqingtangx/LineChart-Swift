//
//  ViewController.swift
//  LineChart-Swift
//
//  Created by weiqing.twq on 2022/6/1.
//

import UIKit
import F2

class ViewController: UIViewController {

    var canvasView:F2CanvasView?
    var chart:F2Chart?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "折线图";
        
        //Step 1 init a canvas view to show chart
        //Step 1 初始化一个view来承载图表的显示
        self.canvasView = F2CanvasView.canvas(CGRect(x:0, y: 100, width: self.view.frame.width, height: 200))
        self.view.addSubview(self.canvasView!)
        
        //Step 2 prepare a chart for drawing
        //Step 2 创建一个chart对象准备绘制图表
        self.chart = F2Chart.init(self.canvasView!.bounds.size, name: "LineChart-Swift")
        
        //Step 3 connect chart and canvasview
        //Step 3 把chart和canvasView关联起来，因为chart渲染好后需要显示在view上面
        self.chart!.canvas()(self.canvasView!)
        self.chart!.padding()(20, 20, 20, 20)
        
        //Step 4 setup the source data of chart
        //Step 4 设置chart的数据源
        let jsonPath = Bundle.main.path(forResource: "data", ofType: "json")
        guard let jsonString = try? String.init(contentsOfFile: jsonPath!) else {
            return
        }
        let jsonData = F2Utils.toJsonArray(jsonString)
        self.chart!.source()(jsonData)
        
        //Sete 5 draw a line in chart
        //The mapping of the x-axis data is the genre field, and the mapping of the y-axis data is the sold field
        //Step 5 在chart上画一条线，x轴数据的映射是genre字段，y轴数据的映射是sold字段
        //Self.chart!.interval()().position()("genre*sold")
        self.chart!.line()().position()("genre*sold")
        
        //Step 6 draw chart and show on canvas view
        //Step 6 渲染并显示在view上
        self.chart!.render()();
    }


}

