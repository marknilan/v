module poemcode

// mpg mpgsrc poemcode model.v
import structs
import vlibrary
import math
import errors

// run_model calls model functions to display poem model to screen
pub fn run_model(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore,tmpdir string) bool {
	println('\nPoem model for poem type ${poem.poemtype} is as follows: \n ')
	// gotta have one of the programs in the poem module for each type
	match poem.poemtype {
		'rondeau' {
			rondeau(poem, runmode, meter_templates, listdbs,tmpdir)
		}
		'iambpent' {
			iambpent(poem, runmode, meter_templates, listdbs,tmpdir)
		}
		'couplet' {
			couplet(poem, runmode, meter_templates, listdbs,tmpdir)
		}
		else {
			errors.improper_poem_msg(' No poem template')
		}
	}

	return true
}

// showmodel displays the model metadata to the screen using the poem meter
// template selected for the poem type
fn showmodel(poem structs.Poem, templates [][]string) !bool {
	mut lps := poem.lpp / poem.stnz
	mut lprinted := 1
	// model for poems displayed
	println('Model = "${poem.poemtype}" \n')
	mut linerep := []string{}
	for i := 0; i < poem.nop; i++ {
		println('model for poem ${i + 1}')
		// model for stanzas displayed
		for j := 0; j < poem.stnz; j++ {
			println(' ')
			// model for lines per stanza displayed
			for k := 0; (k < lps || lprinted == poem.lpp); k++ {
				// chooses a random line index from templates array for this model
				ln := vlibrary.mkrndint(u32(math.max(templates.len, 1)))!
				if (k == 0 && j == 0) && poem.poemtype == 'rondeau' {
					// this is the rondeau specific refrain						
					linerep = templates[ln][0..math.max((templates[ln].len / 2), 3)]
				}
				if (k == lps - 1 && !(j == 0)) && poem.poemtype == 'rondeau' {
					// on the last line of each stanza after the 1st, print the refrain
					println('${vlibrary.clean_arr_line(linerep)}')
				} else {
					// on the first and every other line just print the normal line
					println('${vlibrary.clean_arr_line(templates[ln][0..])}')
				}
				lprinted++
			}
		}
		println('\n \n')
	}

	return true
}
