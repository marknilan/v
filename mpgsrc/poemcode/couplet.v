module poemcode

// mpg mpgsrc poemcode monorhyme.v
import structs
import vlibrary
import math

// code for monorhyme
pub fn couplet(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore) bool {
	mut templates := [][]string{}
	for template in meter_templates {
		if template[0] == 'couplet' {
			templates << template[2..]
		}
	}
	if runmode.to_lower() in ['m', '-m'] {
		showmodel(poem, templates) or { println('Cant show model') }
	} else {
		allpoems := genpoems(poem, templates, listdbs) or { exit(8) }
		writepoems(allpoems, '/tmp/', poem)
	}
	return true
}


// genpoems generates the poem lines from the model model metadata
// according to the poem meter template selected for the poem type
pub fn couplet_gen(poem structs.Poem, templates [][]string, listdbs structs.MpgListstore) ![][]string {
	mut allpoems := [][]string{}
	mut lps := poem.lpp / poem.stnz
	mut lprinted := 1
	// mut linerep := []string{}	
	mut tmpline := []string{}
	mut lastrhyme := ''
	allpoems << ['Poem type = "${poem.poemtype}" \n']
	for i := 0; i < poem.nop; i++ {
		allpoems << ['generation for poem', (i + 1).str()]
		// model for stanzas displayed
		for j := 0; j < poem.stnz; j++ {
			allpoems << [' ']
			// model for lines per stanza displayed
			for k := 0; (k < lps || lprinted == poem.lpp); k++ {
				// chooses a random line index from templates array for this generation
				ln := vlibrary.mkrndint(u32(math.max(templates.len, 1)))!
				tmpline = get_random_wrds(templates[ln], listdbs)!
				if k in poem.rhyme {
					if !(k == 0) {
						// println('line ${k.str()} WAS ${tmpline}')	
						tmpline = compare_rhymes(mut tmpline, lastrhyme, listdbs)!
						// println('line ${k.str()} NOW ${tmpline}')	
					}
					// println('line ${k.str()} lastrhyme IS ${lastrhyme} LINE IS ${tmpline}')
					lastrhyme = tmpline[tmpline.len - 1]
				} else {
					// println('line ${k.str()} NON RHYMED LINE IS ${tmpline} but has lastrhyme = ${lastrhyme}')
				}
				allpoems << tmpline
				lprinted++
			}
			lastrhyme = ''
			allpoems << [' ']
		}
		allpoems << [' ']
		allpoems << [' ']
	}

	return allpoems
}