module poemcode

// mpg mpgsrc poemcode generate.v
import structs
import vlibrary
import math
import os

// run_generate calls model functions to generate poems to an output file
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

// genpoems generates the poem lines from the model model metadata
// according to the poem meter template selected for the poem type
pub fn genpoems(poem structs.Poem, templates [][]string, listdbs structs.MpgListstore) ![][]string {
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
