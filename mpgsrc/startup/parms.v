module startup

// mpg mpgsrc startup parms.v

import os

// import ../../vlibrary

//reads command line parms, checks them and passes back the TOML 
//configuration file and the run mode - batch or GUI
pub fn read_parms() (string, string) {
	mut cfgfile := ''
	mut runmode := ''
	match os.args.len {
		1 {
			improper_parm_msg('No parms provided MPG must have a mode (m or g or t) and a toml config file')
		}
		2 {
			improper_parm_msg('No TOML file - MPG must have a mode (m or g or t) and a toml config file')
		}
		3 {
			if os.args[1] in (['-m', 'm', 'M', '-M']) {				
				runmode = 'm'
			} else if os.args[1] in (['-g', 'g', 'G', '-G']) {
				runmode = 'g'
			  } else if os.args[1] in (['-t', 't', 'T', '-T']) {
				runmode = 't'
			    } else {
				       improper_parm_msg(' needs a "m" or "g" or "t" flag AND TOML config file')
			      }
		}
		else {
			improper_parm_msg(' too many parms')
		}
	}
	cfgfile = os.args[2]

	return cfgfile, runmode
}

// used for various improper calls by the user
fn improper_parm_msg(localmsg string) {
	println('${localmsg}')
	expected_call := ('MPG expects to be run with like this: 
	           mpg -m pathtoconfigfile/tomlfile.toml (to Model poetry)
	           mpg -g pathtoconfigfile/tomlfile.toml (to Generate poetry)
	           mpg -t pathtoconfigfile/tomlfile.toml (to train MPG)')

	println(expected_call.replace('\n\t', '\n'))
	exit(0)
}
