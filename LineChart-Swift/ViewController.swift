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
        self.title = "LineChart";
        self.view.backgroundColor = UIColor.black;
        
        //init a canvas view to show chart
        //初始化一个view来承载图表的显示
        self.canvasView = F2CanvasView.canvas(CGRect(x:0, y: 100, width: self.view.frame.width, height: 200))
        self.view.addSubview(self.canvasView!)
        
        //prepare a chart for drawing
        //创建一个chart对象准备绘制图表
        self.chart = F2Chart.init(self.canvasView!.bounds.size, name: "LineChart-Swift")
        
        //connect chart and canvasview
        //把chart和canvasView关联起来，因为chart渲染好后需要显示在view上面
        self.chart!.canvas()(self.canvasView!)
        self.chart!.padding()(20, 20, 20, 20)
        
        //setup the source data of chart
        //设置chart的数据源
        let jsonPath = Bundle.main.path(forResource: "data", ofType: "json")
        guard let jsonString = try? String.init(contentsOfFile: jsonPath!) else {
            return
        }
        let jsonData = F2Utils.toJsonArray(jsonString)
        self.chart!.source()(jsonData)
        
        //draw a line in chart
        //The mapping of the x-axis data is the genre field, and the mapping of the y-axis data is the sold field
        //在chart上画一条线，x轴数据的映射是genre字段，y轴数据的映射是sold字段
        self.chart!.interval()().position()("genre*sold").color()("genre", []).style()(["radius": [10, 10, 0, 0]])
        
        //shut down the legend
        //关闭图例
        self.chart!.legend()("genre", ["enable": false])
        
        let block = {(param: Dictionary<AnyHashable, Any>) -> Dictionary<AnyHashable, Any> in
            //get the content of axis
            //轴上的数字的key是content
            let content = param["content"] as! String
            return ["content":  content + "元"]
        } as ItemCallback
        let callback = F2Callback.init(block);
        
        //set label's call back of axis
        //设置axis轴上文字的call back
        self.chart!.axis()("sold", ["label":["item": callback], "grid":["type": "dash", "dash":[4, 4]]]);
        
        //shut down the grid of x-axis
        //关闭x轴的网格线
        self.chart?.axis()("genre", ["grid": false])
        
        //start tooltip of chart
        //打开长按十字线
        self.chart?.tooltip()([:]);
        
        //draw chart and show on canvas view
        //渲染并显示在view上
        self.chart!.render()();
    }
}

