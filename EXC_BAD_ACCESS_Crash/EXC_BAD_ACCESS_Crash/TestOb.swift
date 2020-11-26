//
//  TestOb.swift
//  EXC_BAD_ACCESS_Crash
//
//  Created by mac_25648_newMini on 2020/11/25.
//

import UIKit

class TestOb: NSObject {
    var testob2:TestOBJ2? = TestOBJ2()
    
    func test(){
        testob2?.delegate = self
        testob2?.start()
    }
}

extension TestOb:TestOBJ2Delegate{
    func finish() {
        self.testob2 = nil
    }
}
