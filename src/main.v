module main

import mpgsrc
import vlibrary

fn main() {
	
	mpgsrc.runmpg()
	osstr := vlibrary.find_os()
    println('MPG is running on ${osstr} \n')

}
