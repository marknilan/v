module poemcode

// mpg mpgsrc poemcode rondeau.v

import structs

// code for rondeau
pub fn rondeau(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore) bool {
	if runmode.to_lower() in ['m', '-m'] {
		mut templates := [][]string{}
		for template in meter_templates {
			if template[0] == 'rondeau' {
				templates << template[2..]
			}
		}
		showmodel(poem, templates) or { println('Cant show model') }
	} else {
		println('generate here')
	}

	return true
}

