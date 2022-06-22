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
        
        //step1 初始化一个view来承载图表的显示
        self.canvasView = F2CanvasView.canvas(CGRect(x:0, y: 100, width: self.view.frame.width, height: 200))
        self.view.addSubview(self.canvasView!)
        
        //step2 创建一个chart对象准备绘制图表
        self.chart = F2Chart.init(self.canvasView!.bounds.size, name: "LineChart-Swift")
        
        //step3 把chart和canvasView关联起来，因为chart渲染好后需要显示在view上面
        self.chart!.canvas()(self.canvasView!)
        self.chart!.padding()(20, 20, 20, 20)
        
        //step 4设置chart的数据源
        let jsonPath = Bundle.main.path(forResource: "data", ofType: "json")
        guard let jsonString = try? String.init(contentsOfFile: jsonPath!) else {
            return
        }
        let jsonData = F2Utils.toJsonArray(jsonString)
        self.chart!.source()(jsonData)
        
        //step5 在chart上画一条线，x轴数据的映射是genre字段，y轴数据的映射是sold字段
        //self.chart!.interval()().position()("genre*sold")
        self.chart!.line()().position()("genre*sold")
        
        //step6 渲染并显示在view上
        self.chart!.render()();
    }


}

