module poemcode

// mpg mpgsrc poemcode iambpent.v
import structs
import vlibrary
import math

// iambpent is the poem generation code for Iambic Pentameter poems
pub fn iambpent(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore) bool {
	mut templates := [][]string{}
	for template in meter_templates {
		if template[0] == 'iambpent' {
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

fn imb_genline(lprinted int, templates [][]string, poem structs.Poem, listdbs structs.MpgListstore ) !([]string, string) {

            mut lastrhyme := ''
            mut tmpline := []string{}
            for k := 0; (k < poem.lps || lprinted == poem.lpp); k++ {
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
			}
    return tmpline, lastrhyme
}