module main

// mpg src main.v
// mpg compile entry point
import mpgsrc
import vlibrary
import time

// main  is the entry point of the V program
fn main() {
	println('MPG  started  at ${time.now()} \n')
	println('MPG is running on ${vlibrary.find_os()} \n')
	// runs the MPG application
	mpgsrc.runmpg()!
	println('MPG finished  at ${time.now()} \n')
	exit(0)
}
