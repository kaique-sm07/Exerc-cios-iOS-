import Foundation

let concurrentQueue = dispatch_get_global_queue(Int(QOS_CLASS_USER_INTERACTIVE.value), 0)

let serialQueue = dispatch_queue_create("com.augustorsouza.serialQueue", DISPATCH_QUEUE_SERIAL)

// Semaphores array to help in waiting for everything to finish
var semaphores = [AnyObject]()


// Function that dispatches a simple block X times in a predetermined queue
func dispatch(times: Int, queue: dispatch_queue_t) {
  for i in 0..<times {
    let sem = dispatch_semaphore_create(0)
    dispatch_async(queue) {
        println("Hello world")
        dispatch_semaphore_signal(sem)
    }
    semaphores.append(sem)
  }
}

dispatch(3, concurrentQueue)

// Just wait for everything to finish
for sem in semaphores {
  let sem = sem as! dispatch_semaphore_t
  dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER)
}
