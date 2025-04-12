module main

// src main.v

import mpgsrc
import vlibrary
import time

//entry point
fn main() {
	println('MPG  started  at ${time.now()} \n')	
	println('MPG is running on ${vlibrary.find_os()} \n')
	mpgsrc.runmpg()
    println('MPG finished  at ${time.now()} \n')
    exit(0)
}