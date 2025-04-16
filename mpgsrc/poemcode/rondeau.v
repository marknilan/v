module poemcode

// mpg mpgsrc poemcode rondeau.v

//  poemtype string
//  nop int
//  bpl int
//  tmpl string
//  meter string
//  lpp int
//  stnz int
//  rhyme int
import structs
import vlibrary
import math

// code for rondeau
pub fn rondeau(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore) bool {
	if runmode.to_lower() in ['m', '-m'] {
		mut templates := [][]string{}
		for template in meter_templates {
			if template[0] == 'rondeau' {
				templates << template[2..]
			}
		}
		showmodel(poem, templates) or { println('Cant show model') }
	} else {
		println('generate here')
	}

	return true
}

// displays the model for this poem
fn showmodel(poem structs.Poem, templates [][]string) !bool {
	mut lps := poem.lpp / poem.stnz
	mut lprinted := 1
	// model for poems displayed
	println('Model = "Rondeau" \n')
	mut linerep := []string{}
	for i := 0; i < poem.nop; i++ {
		println('model for poem ${i + 1}')
		// model for stanzas displayed
		for j := 0; j < poem.stnz; j++ {
			println(' ')
			// model for lines per stanza displayed
			for k := 0; (k < lps || lprinted == poem.lpp); k++ {
				// chooses a random line index from templates array for this model
				ln := vlibrary.mkrndint(u32(math.max(templates.len, 1)))!
				if k == 0 && j == 0 {
					// this is the refrain						
					linerep = templates[ln][0..math.max((templates[ln].len / 2),3)]					
				}
				if k == lps - 1 && !(j == 0) {
					// on the last line of each stanza after the 1st, print the refrain
					println('${vlibrary.clean_arr_line(linerep)}')
				} else {
					//on the first and every other line just print the normal line
					println('${vlibrary.clean_arr_line(templates[ln][0..])}')
				}
				lprinted++
			}
		}
		println('\n \n')
	}

	return true
}
