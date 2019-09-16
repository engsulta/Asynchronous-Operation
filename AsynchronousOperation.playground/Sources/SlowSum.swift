import Foundation

public func slowAdd(_ input: (Int, Int),completion : @escaping ((Int)->Void)) {
    
    DispatchQueue.global(qos:.utility).async{
        sleep(1)
        DispatchQueue.main.async {
            completion( input.0 + input.1)
        }
    }
}
