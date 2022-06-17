//
//  ViewController.swift
//  My16weeks
//
//  Created by bro on 2022/06/16.
//

import UIKit

protocol myProtocol: AnyObject {
    
}

enum GameJob {
    case warrior
    case rogue
}

class Game {
    var level = 5
    var name = "도사"
    var job: GameJob = .warrior
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //copyOnWrite()
        //aboutSubscipt()
        aboutForeach()
    }

    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
    }
    
    //AnyObject vs Any
    //런타임 시점에 타입이 결정된다. -> 런타임 오류
    //컴파일 시점에는 알 수 없다.
    //Any: Class, Struct, Enum, Clouser등 모든 것을 받는다
    //AnyObject: Class만 담을 수 있다. 프로토콜이다.
    func aboutAnyObject() {
        let name = "고래밥"
        let gender = false
        let age = 10
        
        let characters = Game()
        
        let anylist: [Any] = [name, gender, age, characters]
        let anyObjectlist: [AnyObject] = [characters]
        
        print(anylist, anyObjectlist)
        
        if let value = anylist[0] as? String {
            print(value)
        }
    }
    
    //수정되기 전까지 원본(메모리 주소)를 공유 -> 값이 변경이 되면 그 이후 복사된다(Collection Type에서 이렇게 처리된다)
    func copyOnWrite() {
        
        var nickname = "jack"
        print(address(of: &nickname))
        var nicknameByFamily = nickname
        print(address(of: &nicknameByFamily))
        nicknameByFamily = "꽁"
        print(address(of: &nicknameByFamily))
        print(nickname, nicknameByFamily)
        
        var array = Array(repeating: 100, count: 100)
        print(address(of: &array))
        var newArray = array
        print(address(of: &newArray))
        newArray[0] = 0
        print(address(of: &newArray))
        
        var game = Game()
        
        var newGame = game
        
        newGame.level = 595
        
        print(game.level)
        print(newGame.level)
    }

    
    func address(of object: UnsafeRawPointer) -> String {
        let adress = Int(bitPattern: object)
        return String(format: "%p", adress)
        
    }
    
    //CollectionType: Collection, Sequence, Subscript
    //Subscript -> 대괄호를 통해서 값을 가져올 수 있도록 되어있는 문법
    func aboutSubscipt() {
        
        let array = [1,2,3,4,5]
        
        array[2]
        
        let dic = ["도사": 595, "도적" : 594]
        dic["도사"]
        
        let str = "Hello World"
        str[0]
        print(str[2], str[1])
        
        
        struct UserPhone {
            var numbers = ["01012341234", "01023452345", "01033334444"]
            
            subscript(idx: Int) -> String {
                get {
                    return self.numbers[idx]
                }
                set {
                    self.numbers[idx] = newValue
                }
            }
            
        }
        
        var value = UserPhone()
        value[0]
        print(value[1])
        value[1] = "1234"
        print(value[1])
        
        
    }
    
    func aboutForeach() {
        //break, continue
        let array = [1,2,3,4,5,6,7,8,9]
        
//        for i in array {
//            print(i)
//            return
//        }
        
        array.forEach { i in
            print(i)
            return
        }
        
    }
    
    
    //라이브러리, 프레임워크
    //@frozen: 계속 추가 될 수 있는 가능성이 없는 열거형 swift 4.2에서 추가, 컴파일시에 최적화
    //Unfrozen Enumeration: 계속 추가 될 수 있는 가능성을 가진 열거형
    //@unknown: default
    func aboutEnum() {
                
        let size = UIUserInterfaceSizeClass.compact
        
//        switch size {
//        case .unspecified:
//            <#code#>
//        case .compact:
//            <#code#>
//        case .regular:
//            <#code#>
//        }
    }
    
}

extension String {
    
    subscript(idx: Int) -> String? {
        guard (0..<count).contains(idx) else {
            return nil
        }
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
    }
    
}
