import Foundation

open class AsyncOperation: Operation {
    
    public enum State: String {
        case Ready, Executing, Finished
        
        fileprivate var keyPath: String {
            return "is" + rawValue
        }
    }
    
    public var state = State.Ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
}


extension AsyncOperation {
    // NSOperation Overrides
    override open var isReady: Bool {
        return super.isReady && state == .Ready
    }
    
    override open var isExecuting: Bool {
        return state == .Executing
    }
    
    override open var isFinished: Bool {
        return state == .Finished
    }
    
    override open var isAsynchronous: Bool {
        return true
    }
    
    override open func start() {
        if isCancelled {
            state = .Finished
            return
        }
        
        main()
        state = .Executing
    }
    
    open override func cancel() {
        state = .Finished
    }
}

