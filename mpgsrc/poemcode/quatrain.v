module poemcode

// mpg mpgsrc poemcode quatrain.v
import structs
import vlibrary
import rhymebeat
import proveout
// import math

// iambpent is the poem generation code for Iambic Pentameter poems
pub fn quatrain(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore, outfile string) bool {
	mut templates := [][]string{}
	for template in meter_templates {
		if template[0] == 'quatrain' {
			templates << template[2..]
		}
	}
	if runmode.to_lower() in ['m', '-m'] {
		proveout.showmodel(poem, templates) or { println('Cant show model') }
	} else {
		allpoems := quat_gen(poem, templates, listdbs) or { exit(8) }
		proveout.writepoems(allpoems, outfile, poem)
	}

	return true
}

// quat_gen generates the poem lines from the quatrain model metadata
// according to the poem meter template selected for the poem type
pub fn quat_gen(poem structs.Poem, templates [][]string, listdbs structs.MpgListstore) ![][]string {
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
				tmpline, beatmax = rhymebeat.get_random_wrds(templates[ln], listdbs, beatmax,
					poem)!
				// is this rhyming line then get the rhyming word
				if k in poem.rhyme {
					lastrhyme = tmpline[tmpline.len - 1]
				}
				if k in [1,3] {
					//if !(k == 0) {
						tmpline = rhymebeat.compare_rhymes(mut tmpline, lastrhyme, listdbs)!
					//}
					// keep the last word of the line as a rhyming word					
				}
				// println('tmpline: ${tmpline}')
				allpoems << tmpline
				lprinted++
				if beatmax == 0 {
					//                   println('beatmax is now ${beatmax}')
					beatmax = poem.bpl
				}
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
