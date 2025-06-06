module poemcode

// mpg mpgsrc poemcode iambpent.v
import structs
import vlibrary
//import math

// iambpent is the poem generation code for Iambic Pentameter poems
pub fn iambpent(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore, tmpdir string) bool {
	mut templates := [][]string{}
	for template in meter_templates {
		if template[0] == 'iambpent' {
			templates << template[2..]
		}
	}
	if runmode.to_lower() in ['m', '-m'] {
		showmodel(poem, templates) or { println('Cant show model') }
	} else {
		allpoems := imb_gen(poem, templates, listdbs) or { exit(8) }
		writepoems(allpoems, tmpdir, poem)
	}

	return true
}

// imb_gen generates the poem lines from the iambic model metadata
// according to the poem meter template selected for the poem type
pub fn imb_gen(poem structs.Poem, templates [][]string, listdbs structs.MpgListstore) ![][]string {
	mut allpoems := [][]string{}
	mut lps := poem.lpp / poem.stnz
	mut lprinted := 1
	mut tmpline := []string{}
	mut lastrhyme := ''
	mut beatmax := poem.bpl
	allpoems << ['Poem type = "${poem.poemtype}" \n']
	// number of poems
	for i := 0; i < poem.nop; i++ {
		allpoems << ['generation for poem', (i + 1).str()]
		// model for stanzas displayed
		for j := 0; j < poem.stnz; j++ {
			allpoems << [' ']
			// lines per stanza
			for k := 0; (k < lps || lprinted == poem.lpp); k++ {
				// chooses a random line index from templates array for this generation
				ln := vlibrary.mkrndint(u32(templates.len))!
				tmpline, beatmax = get_random_wrds(templates[ln], listdbs, beatmax)!
				//is this rhyming line then get the rhyming word
				if k in poem.rhyme {
					if !(k == 0) {
						tmpline = compare_rhymes(mut tmpline, lastrhyme, listdbs)!
					}
					//keep the last word of the line as a rhyming word 
					lastrhyme = tmpline[tmpline.len - 1]
				}
				allpoems << tmpline
				if beatmax <= 0 {
					break
				}  
				lprinted++
				println('beatmax is now ${beatmax}')
			}
			lastrhyme = ''
			allpoems << [' ']
			beatmax = poem.bpl
		}
		allpoems << [' ']
		allpoems << [' ']
	}

	return allpoems
}