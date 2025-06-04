module poemcode

// mpg mpgsrc poemcode monorhyme.v
import structs
import vlibrary
//import math

// couplet code for monorhyme
pub fn couplet(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore, tmpdir string) bool {
	mut templates := [][]string{}
	for template in meter_templates {
		if template[0] == 'couplet' {
			templates << template[2..]
		}
	}
	if runmode.to_lower() in ['m', '-m'] {
		showmodel(poem, templates) or { println('Cant show model') }
	} else {
		allpoems := couplet_gen(poem, templates, listdbs) or { exit(8) }
		writepoems(allpoems, tmpdir, poem)
	}
	return true
}


// couplet_gen genpoems generates the poem lines from the model model metadata
// according to the poem meter template selected for the poem type
pub fn couplet_gen(poem structs.Poem, templates [][]string, listdbs structs.MpgListstore) ![][]string {
	mut allpoems := [][]string{}
	mut lps := poem.lpp / poem.stnz
	println(lps)
	mut lprinted := 1
	// mut linerep := []string{}	
	mut tmpline := []string{}
	mut lastrhyme := ''
	allpoems << ['Poem type = "${poem.poemtype}" \n']
	// number of poems
	for i := 0; i < poem.nop; i++ {
		allpoems << ['generation for poem', (i + 1).str()]
		// number of stanzas
		for j := 0; j < poem.stnz; j++ {
			allpoems << [' ']
			// lines per stanza
			for k := 0; (k < lps || lprinted == poem.lpp); k++ {
				// chooses a random line index from templates array for this generation
				ln := vlibrary.mkrndint(u32(templates.len))!
				tmpline = get_random_wrds(templates[ln], listdbs)!
				//if the currently processing line is marked as a rhyming line
				if k in poem.rhyme {
					//not the first line obviously. now make a rhyme
					if !(k == 0) {
						tmpline = compare_rhymes(mut tmpline, lastrhyme, listdbs)!
					}
					// keep the last rhyming word
					lastrhyme = tmpline[tmpline.len - 1]
				} else {
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