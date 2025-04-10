module mpgsrc

// mpgsrc mpg.v

import startup
import injest

//runs the mpg program
pub fn runmpg() {
	cfgfile, runmode := startup.read_parms()
	poem := startup.config(cfgfile,runmode)
	println(poem)
    mpgwords := injest.get_words('/home/mark/projects/v/mpg/words/mpgwords.csv')
    println(mpgwords)
}

