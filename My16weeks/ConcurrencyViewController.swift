//
//  ConcurrencyViewController.swift
//  My16weeks
//
//  Created by bro on 2022/06/16.
//

import UIKit

class ConcurrencyViewController: UIViewController {
    
    let url1 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
    let url2 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
    let url3 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


    @IBAction func basic(_ sender: UIButton) {
        
        print("Hello World")
        
        for i in 1...100 {
            print(i, terminator:  " ")
        }
        
        for i in 101...200 {
            print(i, terminator:  " ")
        }
        
        print("Bye Bye")
        
    }
    
    @IBAction func mainAsync(_ sender: UIButton) {
        print("Hello World")
        
        DispatchQueue.main.async {
            for i in 1...100 {
                print(i, terminator:  " ")
            }
        }
                
        for i in 101...200 {
            print(i, terminator:  " ")
        }
        
        print("Bye Bye")
    }
    
    @IBAction func globalSycnAsync(_ sender: UIButton) {
        print("Hello World")
        
        //global.sync -> 메인쓰레드로 보내는 것과 동일한게 아닌가?
        //다른 쓰레드로 동기적으로 보내는 코드라도 실질적으로는 메인쓰레드에서 일함.
        //global().sync는 거의 사용되지 않는다
//        DispatchQueue.global().async {
//            for i in 1...100 {
//                print(i, terminator:  " ")
//            }
//        }
        
        
        
        for i in 1...100 {
            DispatchQueue.global().async {
                print(i, terminator:  " ")
            }
        }
        
                
        for i in 101...200 {
            print(i, terminator:  " ")
        }
        
        print("Bye Bye")
    }
    
    
    @IBAction func globalQos(_ sender: Any) {
        

        
        DispatchQueue.global(qos: .background).async {
            for i in 1...100 {
                print(i, terminator:  " ")
            }
        }
        
        //let queue = DispatchQueue(label: "Jack") //Serial
        let queue = DispatchQueue(label: "ConcurrentJack", qos: .userInteractive, attributes: .concurrent) //Concurrent
        
        queue.async {
            for i in 101...200 {
                print(i, terminator:  " ")
            }
        }
        
        DispatchQueue.global(qos: .utility).async {
            for i in 201...300 {
                print(i, terminator:  " ")
            }
        }
        
        print("끝")
    }
    
    @IBAction func dispatchGroup(_ sender: Any) {
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator:  " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator:  " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator:  " ")
            }
        }
        
        print("test")
        
        group.notify(queue: .main) {
            print("끝")
            self.view.backgroundColor = .blue
        }
        
    }
    
    @IBAction func urlsessionDispatchGroup(_ sender: Any) {
        
        
        let group = DispatchGroup()
        
//        DispatchQueue.global().async(group: group) {
//            self.request(url: <#T##URL#>) { image in
//                print("image1")
//            }
//        }
//
//        DispatchQueue.global().async(group: group) {
//            self.request(url: <#T##URL#>) { image in
//                print("image2")
//            }
//        }
//
//        DispatchQueue.global().async(group: group) {
//            self.request(url: <#T##URL#>) { image in
//                print("image3")
//            }
//
//        }
//
//        group.notify(queue: .main) {
//            print("작업 완료")
//        }

        
        group.enter()
        request(url: url1) { image in
            print("image1")
            group.leave()
        }
        
        group.enter()
        request(url: url1) { image in
            print("image2")
            group.leave()
        }
        
        group.enter()
        request(url: url1) { image in
            print("image3")
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("끝")
        }
        
    }
    
    func request(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            let image = UIImage(data: data)
            completionHandler(image)
        }.resume()
    }
    
}
