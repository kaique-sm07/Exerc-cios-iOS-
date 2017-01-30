import Foundation

let sync = false

println("Hello World 1")

// Semaphores array to help in waiting for everything to finish
var semaphores = [AnyObject]()

let sem = dispatch_semaphore_create(0)
semaphores.append(sem)

let queue = dispatch_get_global_queue(Int(QOS_CLASS_USER_INTERACTIVE.value), 0)


if sync {
  dispatch_sync(queue) {
      println("Hello World 2")
      dispatch_semaphore_signal(sem)
  }
} else {
  dispatch_async(queue) {
      println("Hello World 2")
      dispatch_semaphore_signal(sem)
  } 
}

println("Hello World 3")

// Just wait for everything to finish
for sem in semaphores {
    let sem = sem as! dispatch_semaphore_t
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER)
}