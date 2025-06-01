module poemcode

// mpg mpgsrc poemcode generate.v
import structs
import vlibrary
//import math
import os

// run_generate calls model functions to generate poems to an output file
pub fn run_generate(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore, tmpdir string) bool {
	outfile := '/tmp/' + vlibrary.make_random_filename('mpg', poem.poemtype, 'txt')
	println('\nPoem generation for poem type ${poem.poemtype} to ${outfile} is as follows: \n ')
	// gotta have one of the programs in the poem module for each type
	match poem.poemtype {
		'rondeau' {
			rondeau(poem, runmode, meter_templates, listdbs, tmpdir)
		}
		'iambpent' {
			iambpent(poem, runmode, meter_templates, listdbs, tmpdir)
		}
		'couplet' {
			couplet(poem, runmode, meter_templates, listdbs, tmpdir)
		}
		else {
			improper_poem_msg(' No poem template')
		}
	}

	return true
}


// writepoems writes out to tmp file the generated poems
fn writepoems(allpoems [][]string, opath string, poem structs.Poem) bool {
	outfile := opath + vlibrary.make_random_filename('mpg', poem.poemtype, 'txt')
	mut file := os.create(outfile) or { exit(8) }
	for line in allpoems {
		ostr := vlibrary.clean_arr_line(line).replace('  ', ' ').to_lower().capitalize()
		println(ostr)
		file.write_string(' ${ostr} \n') or { exit(8) }
	}
	defer { file.close() }

	return true
}
