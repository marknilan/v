module poemcode

// mpg mpgsrc poemcode rondeau.v
import structs
import vlibrary
import math

// rondeau code for rondeau type poem
pub fn rondeau(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore, tmpdir string) bool {
	mut templates := [][]string{}
	for template in meter_templates {
		if template[0] == 'rondeau' {
			templates << template[2..]
		}
	}
	if runmode.to_lower() in ['m', '-m'] {
		showmodel(poem, templates) or { println('Cant show model') }
	} else {
		allpoems := ron_gen(poem, templates, listdbs) or { exit(8) }
		writepoems(allpoems, 'tmpdir', poem)
	}
	return true
}

// ron_gen generates the poem lines from the poem type model metadata
// each line according to the poem meter templates collected for the poem type
pub fn ron_gen(poem structs.Poem, templates [][]string, listdbs structs.MpgListstore) ![][]string {
	mut allpoems := [][]string{}
	mut lps := poem.lpp / poem.stnz
	println(lps)
	mut lprinted := 1
	mut linerep := []string{}
	mut tmpline := []string{}
	mut lastrhyme := []string{}	
	beatmax := poem.bpl
	allpoems << ['Poem type = "${poem.poemtype}" \n']
	// number of poems
	for i := 0; i < poem.nop; i++ {
		allpoems << ['generation for poem', (i + 1).str()]
		allpoems << [' ']
		// number of stanzas
		for j := 0; j < poem.stnz; j++ {
			// lines per stanza
			for k := 0; (k < lps || lprinted == poem.lpp); k++ {
				// chooses a random line index from templates array for this generation
				ln := vlibrary.mkrndint(u32(templates.len))!
				tmpline = get_random_wrds(templates[ln], listdbs, beatmax)!
				if j == 0 && linerep.len == 0 {
					// first line of first stanza - collect the refrain
					linerep = tmpline[0..math.max((templates[ln].len / 3), 2)].clone()
				}
				// is this a rhyming line? then keep the last word as a rhyme future match
				if k in poem.rhyme {				    
					lastrhyme << tmpline[tmpline.len - 1]					
				} 
				// always line 3 rhymes with line 1 (index start = 0 remember)
				if k == 2 {                
                   tmpline = compare_rhymes(mut tmpline, lastrhyme[0], listdbs)! 
				}
				//always line 4 rhymes with line 2 (index start = 0 remember)
				if k == 3 {                
                   tmpline = compare_rhymes(mut tmpline, lastrhyme[1], listdbs)! 
				} 
				// the refrain on each stanza last line except the first
				if k == lps - 1 && !(j == 0) {
					allpoems << linerep
				} else {
					allpoems << tmpline
				}
				lprinted++
			}
			lastrhyme = []string{}			
			allpoems << [' ']
		}
		linerep = []string{}
		allpoems << [' ']
		allpoems << [' ']
	}

	return allpoems
}
