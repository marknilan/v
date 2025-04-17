module poemcode

// mpg mpgsrc poemcode generate.v

import structs
import vlibrary
import math

// calls model functions to generate poems to an output file
pub fn run_generate(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore) bool {
    outfile := '/tmp/' + vlibrary.make_random_filename('mpg', poem.poemtype, '.txt')
	println('\nPoem generation for poem type ${poem.poemtype} to ${outfile} is as follows: \n ')
	// gotta have one of the programs in the poem module for each type
	match poem.poemtype {
		'rondeau' {
			rondeau(poem, runmode, meter_templates, listdbs)
		}
        'iambpent' {
			iambpent(poem, runmode, meter_templates, listdbs)
		} 
		else {
			improper_poem_msg(' No poem template')
		}
	}

	return true
}


// displays the model metadata to the screen using the poem meter 
// template selected for the poem type
pub fn genpoems(poem structs.Poem, templates [][]string, listdbs structs.MpgListstore) !bool {
	mut lps := poem.lpp / poem.stnz
	mut lprinted := 1
	// generate for poems displayed
	println('Poem generation = "${poem.poemtype}" \n')
	mut linerep := []string{}
	for i := 0; i < poem.nop; i++ {
		println('generation for poem ${i + 1}')
		// model for stanzas displayed
		for j := 0; j < poem.stnz; j++ {
			println(' ')
			// model for lines per stanza displayed
			for k := 0; (k < lps || lprinted == poem.lpp); k++ {
				// chooses a random line index from templates array for this generation
				ln := vlibrary.mkrndint(u32(math.max(templates.len, 1)))!				
				if (k == 0 && j == 0) && poem.poemtype == 'rondeau' {
					// this is the rondeau specific refrain						
					linerep = templates[ln][0..math.max((templates[ln].len / 2),3)]					
				}
				if (k == lps - 1 && !(j == 0)) && poem.poemtype == 'rondeau' {
					// on the last line of each stanza after the 1st, generate the refrain
                    get_random_wrd(linerep,listdbs)
					
				} else {
					//on the first and every other line just generate the normal line
                    get_random_wrd(linerep,listdbs)
					
				}				
				lprinted++
			}
		}
		println('\n \n')
	}

	return true
}

fn get_random_wrd(template []string, listdbs structs.MpgListstore) {
	println('inside call to pick random words')
}