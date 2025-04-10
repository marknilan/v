module mpgsrc

import time
import startup

pub fn runmpg() {
	println('MPG  started  at ${time.now()} \n')
	cfgfile, runmode := startup.read_parms()
	poem := startup.config(cfgfile)
	println('MPG was called in mode: ${runmode} with TOML file: ${cfgfile} \n')
	println('poem metadata is as follows: \n${poem}')
	println('MPG finished  at ${time.now()} \n')
}

