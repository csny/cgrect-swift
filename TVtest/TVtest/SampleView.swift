//
//  SampleView.swift
//  TVtest
//
//  Created by macbook on 2015/04/27.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

import UIKit
import QuartzCore

class SampleView: UIView {
    // 方眼のタッチ有無を格納する二次元配列を
    // インスタンス変数として準備し、初期化
    var isYellowArr = [[Bool]](count: 8, repeatedValue: [Bool](count: 6, repeatedValue: false))
    
    required init(coder: NSCoder) {
        // こっちは呼ばれないよ
        super.init(coder: coder)
        println("initNSCoder")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    override func drawRect(rect: CGRect) {
        // 描画管理の構造体contextを初期化
        let context: CGContextRef = UIGraphicsGetCurrentContext()
        
        // 色を定義
        let red: [CGFloat] = [1.0, 0.0, 0.0, 1.0]
        let blue: [CGFloat] = [0.0, 0.0, 1.0, 1.0]
        let cyan: [CGFloat] = [0.5, 0.8, 1.0, 1.0]
        let green: [CGFloat] = [0.0, 1.0, 0.0, 1.0]
        let white: [CGFloat] = [1.0, 1.0, 1.0, 0.5]
        let yellow: [CGFloat] = [1.0, 1.0, 0.0, 0.5]
        
        // グリッドを描画
        CGContextSetStrokeColor(context, cyan)
        CGContextBeginPath(context)
        CGContextSetLineWidth(context, 0.5)
        for (var y: Int = 50; y < Int(self.bounds.size.height); y+=50) {
            CGContextMoveToPoint(context, 0, CGFloat(y))
            CGContextAddLineToPoint(context, self.bounds.size.width, CGFloat(y))
        }
        for (var x: Int = 50; x < Int(self.bounds.size.width); x+=50) {
            CGContextMoveToPoint(context, CGFloat(x), 0)
            CGContextAddLineToPoint(context, CGFloat(x), self.bounds.size.height)
        }
        CGContextStrokePath(context)
        
        // フラグに応じて矩形を描画、タッチイベントで再描画される
        for(var i: Int=0;i<8;i++){
            for(var j: Int=0;j<6;j++){
                if(isYellowArr[i][j]){
                    CGContextSetFillColor(context, yellow)
                    CGContextFillRect(context, CGRectMake(CGFloat(i)*50,CGFloat(j)*50,50,50))
                }else{
                    CGContextSetFillColor(context, white);
                    CGContextFillRect(context, CGRectMake(CGFloat(i)*50,CGFloat(j)*50,50,50))
                }
            }
        }
        
        // 矩形を描画
        CGContextSetFillColor(context, green)
        CGContextFillRect(context, CGRectMake(50, 400, 50, 50))
        
        // 円を描画
        CGContextSetFillColor(context, blue)
        CGContextFillEllipseInRect(context, CGRectMake(250, 400, 50, 100))
        
        // 多角形を描画
        CGContextSetFillColor(context, red)
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, 150, 450)
        CGContextAddLineToPoint(context, 200, 500)
        CGContextAddLineToPoint(context, 200, 400)
        CGContextFillPath(context)
        
        // 文字表示定義
        let myLabel: UILabel = UILabel(frame: CGRectMake(50,300,250,50))
        myLabel.text = "上はタッチで動作、下は固定画像"
        myLabel.font = UIFont(name:"AvenirNext-Italic",size:14)
        myLabel.textColor = UIColor.redColor()
        myLabel.backgroundColor = UIColor.cyanColor();
        // Viewにラベルを追加
        self.addSubview(myLabel)
    }
    
    // タッチイベント発生時の処理
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // タッチ位置を点で取得
        let touch: UITouch = touches.first as! UITouch
        var pos: CGPoint = touch.locationInView(self)
        
        // タッチ位置と方眼位置を比較
        for(var i: Int=0;i<8;i++){
            for(var j: Int=0;j<6;j++){
                if CGRectContainsPoint(CGRectMake(CGFloat(i)*50,CGFloat(j)*50,50,50), pos) {
                    if(isYellowArr[i][j]){
                        isYellowArr[i][j]=false
                    }else{
                        isYellowArr[i][j]=true
                    }
                }
            }
        }
        // 適当に範囲指定して画面上半分を再描画
        //self.setNeedsDisplay()
        self.setNeedsDisplayInRect(CGRectMake(self.bounds.origin.x,self.bounds.origin.y,self.bounds.size.width,300))
    }
    
/* その他のタッチ動作もあるらしい
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("touchesEnded")
    }
    override func touchesCancelled(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("touchesCancelled")
    }
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("touchesMoved")
    super.touchesMoved(touches , withEvent:event)
        
    }
*/
}
