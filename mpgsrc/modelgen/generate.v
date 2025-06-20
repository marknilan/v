module modelgen

// mpg mpgsrc poemcode generate.v
import structs
import vlibrary
import errors
import poemcode

// run_generate calls model functions to generate poems to an output file
pub fn run_generate(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore, tmpdir string) bool {
	outfile := tmpdir + vlibrary.make_random_filename('mpg', poem.poemtype, 'txt')
	println('\nPoem generation for poem type ${poem.poemtype} to ${outfile} is as follows: \n ')
	// gotta have one of the programs in the poem module for each type
	match poem.poemtype {
		'rondeau' {
			poemcode.rondeau(poem, runmode, meter_templates, listdbs, outfile)
		}
		'iambpent' {
			poemcode.iambpent(poem, runmode, meter_templates, listdbs, outfile)
		}
		'couplet' {
			poemcode.couplet(poem, runmode, meter_templates, listdbs, outfile)
		}
		'quatrain' {
			poemcode.quatrain(poem, runmode, meter_templates, listdbs, outfile)
		}
		'terzarima' {
			poemcode.terzarima(poem, runmode, meter_templates, listdbs, outfile)
		}
		else {
			errors.improper_poem_msg(' No poem template')
		}
	}

	return true
}
