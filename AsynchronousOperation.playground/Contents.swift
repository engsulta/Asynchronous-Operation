
import Foundation
import UIKit
import PlaygroundSupport

//PlaygroundPage.current.needsIndefiniteExecution = true

class SumOperationAsynch: AsyncOperation {
    
    fileprivate var input : (Int,Int)
    var result: Int?
    
    init(input : (Int,Int))  {
        self.input = input
        super.init()
        
    }
    
    override func main() {
        guard !isCancelled else {return}
        
        slowAdd(input){ result in
            self.result = result
            self.state = .Finished
        }
    }
    
}
 

let sumOp = SumOperationAsynch(input: (5,9))

sumOp.completionBlock = {
    print(sumOp.result ?? 0)
}

let operationQueue = OperationQueue()
    
operationQueue.addOperation(sumOp)




