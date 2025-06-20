module poemcode

// mpg mpgsrc poemcode terzarima.v
import structs
import vlibrary
import rhymebeat
import proveout
// import math

// terzarima is the poem generation code for Terza Rima poems
pub fn terzarima(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore, outfile string) bool {
	mut templates := [][]string{}
	for template in meter_templates {
		if template[0] == 'terzarima' {
			templates << template[2..]
		}
	}
	if runmode.to_lower() in ['m', '-m'] {
		proveout.showmodel(poem, templates) or { println('Cant show model') }
	} else {
		allpoems := terza_gen(poem, templates, listdbs) or { exit(8) }
		proveout.writepoems(allpoems, outfile, poem)
	}

	return true
}

// terza_gen generates the poem lines from the terzarima model metadata
// according to the poem meter template selected for the poem type
pub fn terza_gen(poem structs.Poem, templates [][]string, listdbs structs.MpgListstore) ![][]string {
	mut allpoems := [][]string{}
	mut lps := 3
	mut lprinted := 1
	mut tmpline := []string{}
	mut beatmax := poem.bpl
	mut lastrhyme := ''
	mut finalrhyme := ''
	allpoems << ['Poem type = "${poem.poemtype}" \n']
	// number of poems
	for i := 0; i < poem.nop; i++ {
		allpoems << ['generation for poem', (i + 1).str()]
		// model for stanzas displayed
		for j := 0; j < poem.stnz; j++ {
			allpoems << [' ']
			// lines per stanza
			println('stanza ${j}')
			for k := 0; (k < lps || lprinted == poem.lpp + 1); k++ {
				println('k is ${k} and lprinted is ${lprinted}')
				// chooses a random line index from templates array for this generation
				mut ln := vlibrary.mkrndint(u32(templates.len))!
				tmpline, beatmax = rhymebeat.get_random_wrds(templates[ln], listdbs, beatmax,
					poem)!
				// is this rhyming line then get the rhyming word
				if k == 0 {
					lastrhyme = tmpline[tmpline.len - 1]
				}
				if k == 1 && j == poem.stnz {
					finalrhyme = tmpline[tmpline.len - 1]
					println('final rhyme is ${finalrhyme}')
				}
				if k == 2 {
					tmpline = rhymebeat.compare_rhymes(mut tmpline, lastrhyme, listdbs)!
				}

				println('line ${k} is ${tmpline} ')
				if j == poem.stnz && k == 2 {
					allpoems << tmpline
					ln = vlibrary.mkrndint(u32(templates.len))!
					tmpline, beatmax = rhymebeat.get_random_wrds(templates[ln], listdbs,
						beatmax, poem)!
					println('BEFORE last line is ${tmpline}')
					tmpline = rhymebeat.compare_rhymes(mut tmpline, finalrhyme, listdbs)!
					println('line 4 is ${tmpline} ')
				}
				lprinted++
				if beatmax == 0 {
					//                   println('beatmax is now ${beatmax}')
					beatmax = poem.bpl
				}
				allpoems << tmpline
			}
			lastrhyme = ' '
			allpoems << [' ']
			beatmax = poem.bpl
		}

		// println('AFTER last line is ${tmpline}')

		// println('allpoems is now ${allpoems}')
		// allpoems << tmpline
		allpoems << [' ']
		allpoems << [' ']
	}

	return allpoems
}
