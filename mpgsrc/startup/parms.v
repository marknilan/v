module startup

// mpg mpgsrc startup parms.v
// conatins code to handle command line parameters
import os
import errors

// read_parms reads command line parms, checks them and passes back the TOML
// configuration file and the run mode - batch or GUI
pub fn read_parms() (string, string) {
	mut cfgfile := ''
	mut runmode := ''
	match os.args.len {
		1 {
			errors.improper_parm_msg('No parms provided MPG must have a mode (m or g or t) and a toml config file')
		}
		2 {
			errors.improper_parm_msg('No TOML file - MPG must have a mode (m or g or t) and a toml config file')
		}
		3 {
			if os.args[1] in (['-m', 'm', 'M', '-M']) {
				runmode = 'm'
			} else if os.args[1] in (['-g', 'g', 'G', '-G']) {
				runmode = 'g'
			} else if os.args[1] in (['-t', 't', 'T', '-T']) {
				runmode = 't'
			} else {
				errors.improper_parm_msg(' needs a "m" or "g" or "t" flag AND TOML config file')
			}
		}
		else {
			errors.improper_parm_msg(' too many parms')
		}
	}
	cfgfile = os.args[2]

	return cfgfile, runmode
}
