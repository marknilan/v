module poemcode

// mpg mpgsrc poemcode quatrain.v
import structs
import vlibrary
import rhymebeat
import proveout
// import math

// quatrain is the poem generation code for Quatrain poems
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
	// mut lastrhyme := ''
	mut beatmax := poem.bpl
	mut la := []string{}
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
				if k == 0 {
					la << tmpline[tmpline.len - 1]
				}
				if k == 1 {
					la << tmpline[tmpline.len - 1]
				}
				if k == 2 {
					tmpline = rhymebeat.compare_rhymes(mut tmpline, la[0], listdbs)!
				}
				if k == 3 {
					tmpline = rhymebeat.compare_rhymes(mut tmpline, la[1], listdbs)!
				}
				allpoems << tmpline
				lprinted++
				if beatmax == 0 {
					//                   println('beatmax is now ${beatmax}')
					beatmax = poem.bpl
				}
			}
			la = []
			allpoems << [' ']
			beatmax = poem.bpl
		}
		allpoems << [' ']
		allpoems << [' ']
	}

	return allpoems
}
