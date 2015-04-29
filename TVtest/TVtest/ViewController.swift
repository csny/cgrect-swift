//
//  ViewController.swift
//  TVtest
//
//  Created by macbook on 2015/04/27.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // ViewController
        self.view.backgroundColor = UIColor.whiteColor()
        if !addVIEWS() {
            println("addVIEWS, error")
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addVIEWS() -> Bool {
        // 自前UIViewの定義
        // UIViewController.viewの座標取得
        var x:CGFloat = self.view.bounds.origin.x
        var y:CGFloat = self.view.bounds.origin.y
        // UIViewController.viewの幅と高さを取得
        var width:CGFloat = self.view.bounds.width
        var height:CGFloat = self.view.bounds.height
        // 上記より画面ぴったりサイズのフレームを生成する
        var frame:CGRect = CGRect(x: x, y: y, width: width, height: height)
        // カスタマイズViewを生成
        var myView:SampleView = SampleView(frame: frame)
        myView.tag = 5000
        
        // ボタンの定義
        let resetBtn: UIButton = UIButton()
        // タグを設定
        resetBtn.tag = 5001
        // サイズを設定
        resetBtn.frame = CGRectMake(160,270,50,30)
        // 背景色を設定
        resetBtn.backgroundColor = UIColor.blackColor()
        // 枠を丸く
        //resetBtn.layer.masksToBounds = true
        // タイトルを設定
        resetBtn.setTitle("Reset", forState: UIControlState.Normal)
        resetBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        // コーナーの半径を設定
        //resetBtn.layer.cornerRadius = 20.0
        // ボタンの位置を指定
        //resetBtn.layer.position = CGPoint(x: self.view.frame.width/2, y:200)
        // イベントを追加
        resetBtn.addTarget(self, action: "button_Tapped:", forControlEvents: .TouchUpInside)
        
        
        // カスタマイズViewを追加
        self.view.addSubview(myView)
        // カスタマイズviewを最前面へ
        // self.view.bringSubviewToFront(myView)
        // ボタンをViewに追加する.
        self.view.addSubview(resetBtn)
        
        return true
    }
    
    // ボタン動作
    func button_Tapped(sender: UIButton){
        
        // view削除
        let beforeView1: UIView = self.view.viewWithTag(5000)!
        let beforeView2: UIView = self.view.viewWithTag(5001)!
        beforeView1.removeFromSuperview()
        beforeView2.removeFromSuperview()
        /* これでも可
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        */
        
        // view再作成
        if !addVIEWS() {
            println("addVIEWS, error")
            return
        }
    }
}

