//
//  SwizzlingViewController.swift
//  My16weeks
//
//  Created by bro on 2022/06/16.
//

import UIKit


class SwizzlingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ViewWillAppear")
    }
    
    
    
}

extension UIViewController {
    
    //메서드 -> 런타임 실행 메서드
    //#selector : -> C부터 사용되었다.런타임시에 실행될 함수를 찾는다.
    class func swizzleMethod() {
        
        let origin = #selector(viewWillAppear(_:))
        let change = #selector(changeViewWillAppear)
        
        guard let originMethod = class_getInstanceMethod(UIViewController.self, origin), let changeMethod = class_getInstanceMethod(UIViewController.self, change) else {
            print("함수를 찾을 수 없거나 오류")
            return
            
        }
        
        method_exchangeImplementations(originMethod, changeMethod)
        
    }
    
    @objc func changeViewWillAppear() {
        print("changeViewWillAppear") //버전이 안맞을 수 있다, 에러가 생길 수 있다.
    }
    
}
