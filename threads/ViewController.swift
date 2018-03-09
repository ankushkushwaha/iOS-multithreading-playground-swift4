//
//  ViewController.swift
//  threads
//
//  Created by Ankush Kushwaha on 3/9/18.
//  Copyright © 2018 Ankush Kushwaha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let printQueue = DispatchQueue(label: "printQueue", qos: .utility)


    override func viewDidLoad() {
        super.viewDidLoad()
        print ("Start")

//       mainQueueSerial()
//        queue1()
//        queuePriority()
//        randomSerialQueue()
//        randomCuncurrentQueue()
        
        
        let q1 = DispatchQueue(label: "q1", qos: .utility)
        let q2 = DispatchQueue(label: "q1", qos: .utility)

        q1.async { //thread 1
            for i in 0..<100 {

                self.write(i:i)
            }
        }
        
        q2.async { //thread 2
            for i in 0..<100 {

                self.read(i:i)
            }
        }
        
        for i in 0..<5 { //main thread
            
            self.temp(i:i)
        }
        
        print ("End")

    }
    
    func read(i: Int) {

        printQueue.sync {
            
//        objc_sync_enter(self)

        print("🔷open\(i)")
        print("🔷Read\(i)")
        print("🔷close\(i)")

//        objc_sync_exit(self)
        }

    }
    
    func write(i: Int) {
        printQueue.sync {

//        objc_sync_enter(self)
        
        print("⚪️Open\(i)")
        print("⚪️write\(i)")
        print("⚪️Close\(i)")

//        objc_sync_exit(self)
        }
    }
    
    func temp(i: Int) {
        printQueue.sync {
            
            //        objc_sync_enter(self)
            
            print("🔶Open\(i)")
            print("🔶write\(i)")
            print("🔶Close\(i)")
            
            //        objc_sync_exit(self)
        }
    }
    
    
    
    
    func randomCuncurrentQueue() {
        let randomQueue = DispatchQueue(label: "randomQueue", qos: .utility, attributes: .concurrent)
        randomQueue.async {
            

            for i in 0..<10 {
                print("🔷", i)
            }
        }
        randomQueue.async {
            for i in 20..<30 {
                print("⚪️", i)
            }
        }
        randomQueue.async {
            for i in 30..<40 {
                print("🔶", i)
            }
        }
    }
    func randomSerialQueue() {
        let randomQueue = DispatchQueue(label: "randomQueue", qos: .utility)
        
        randomQueue.async {
            
            for i in 0..<10 {
                print("🔷", i)
            }
        }
        randomQueue.async {
            for i in 20..<30 {
                print("⚪️", i)
            }
        }
        randomQueue.async {
            for i in 30..<40 {
                print("🔶", i)
            }
        }
    }
    
    func queuePriority () {
        let firstQueue = DispatchQueue(label: "queue1", qos: DispatchQoS.userInitiated)
        let secondQueue = DispatchQueue(label: "queue2", qos: DispatchQoS.userInitiated)
        firstQueue.async {
            for i in 0..<1000 {
                print("🔷", i)
            }
        }
        secondQueue.async {
            for i in 0..<1000 {
                print("⚪️", i)
            }
        }
    }
    
    func queue1()  {
        // Background thread
        let queue = DispatchQueue(label: "queue.1")

        queue.async {
            for i in 0..<10 {
                print("🔷", i)
            }
        }
        // Main thread
        for i in 20..<30 {
            print("⚪️", i)
        }
        
        
    }

    func mainQueueSerial() {
        
        // cannot use sync in main queue
        
        DispatchQueue.main.async {
            for i in 0 ... 10000 {
                print (i)
            }
            
        }
        
        DispatchQueue.main.async {
            
            for i in 0 ... 10000 {
                print ("hey")
            }
            
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

