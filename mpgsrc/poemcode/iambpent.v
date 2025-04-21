module poemcode

// mpg mpgsrc poemcode iambpent.v
import structs

// iambpent is the poem generation code for Iambic Pentameter poems
pub fn iambpent(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore) bool {
	mut templates := [][]string{}
	for template in meter_templates {
		if template[0] == 'iambpent' {
			templates << template[2..]
		}
	}
	if runmode.to_lower() in ['m', '-m'] {		
		showmodel(poem, templates) or { println('Cant show model') }
	} else {
		allpoems := genpoems(poem, templates, listdbs) or {exit(8)}
		writepoems(allpoems,'/tmp/',poem)	
	}

	return true
}