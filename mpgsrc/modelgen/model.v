module modelgen

// mpg mpgsrc poemcode model.v
import structs
import errors
import poemcode 

// run_model calls model functions to display poem model to screen
pub fn run_model(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore,tmpdir string) bool {
	println('\nPoem model for poem type ${poem.poemtype} is as follows: \n ')
	// gotta have one of the programs in the poem module for each type
	match poem.poemtype {
		'rondeau' {
			poemcode.rondeau(poem, runmode, meter_templates, listdbs,tmpdir)
		}
		'iambpent' {
			poemcode.iambpent(poem, runmode, meter_templates, listdbs,tmpdir)
		}
		'couplet' {
			poemcode.couplet(poem, runmode, meter_templates, listdbs,tmpdir)
		}
		else {
			errors.improper_poem_msg(' No poem template')
		}
	}

	return true
}

