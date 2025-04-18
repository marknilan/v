module poemcode

// mpg mpgsrc poemcode generate.v
import structs
import vlibrary
import math
import os

// calls model functions to generate poems to an output file
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

// generates the poem lines from the model model metadata 
// according to the poem meter template selected for the poem type
pub fn genpoems(poem structs.Poem, templates [][]string, listdbs structs.MpgListstore)! [][]string {
	mut allpoems := [][]string{}
	mut lps := poem.lpp / poem.stnz
	mut lprinted := 1
	mut linerep := []string{}
	allpoems << ['Poem type = "${poem.poemtype}"']
	for i := 0; i < poem.nop; i++ {				
		allpoems << ['generation for poem',(i+1).str()]
		// model for stanzas displayed
		for j := 0; j < poem.stnz; j++ {
			allpoems << [' ']
			// model for lines per stanza displayed
			for k := 0; (k < lps || lprinted == poem.lpp); k++ {
				// chooses a random line index from templates array for this generation
				ln := vlibrary.mkrndint(u32(math.max(templates.len, 1)))!
				if (k == 0 && j == 0) && poem.poemtype == 'rondeau' {
					// this is the rondeau specific refrain						
					linerep = templates[ln][0..math.max((templates[ln].len / 2), 3)]
				}
				if (k == lps - 1 && !(j == 0)) && poem.poemtype == 'rondeau' {					
					// on the last line of each stanza after the 1st, generate the refrain
					allpoems << get_random_wrds(linerep, listdbs)!
				} else {
					// on the first and every other line just generate the normal line
					allpoems << get_random_wrds(templates[ln], listdbs)!
				}				
				lprinted++
			}			
			allpoems << [' ']
		}
		allpoems << [' ']
		allpoems << [' ']
	}

	return allpoems
}

fn get_random_wrds(template []string, listdbs structs.MpgListstore)! []string {
	mut wrdline := []string{}
	for wordtype in template {			   
	   match wordtype {          			   	
		'NOUN' {			
	        wrd := lookuplist(wordtype, listdbs.nouns, listdbs.mpgcounts.nouncnt)!
	        wrdline << wrd
		}
		'VERB' {			
			wrd := lookuplist(wordtype, listdbs.verbs, listdbs.mpgcounts.verbcnt)!
	        wrdline << wrd
		}
        'ADJECTIVE' {        	
			wrd := lookuplist(wordtype, listdbs.adjectives, listdbs.mpgcounts.adjcnt)!
	        wrdline << wrd
		}
        'PRONOUN' {        	
			wrd := lookuplist(wordtype, listdbs.pronouns, listdbs.mpgcounts.proncnt)!
	        wrdline << wrd
		}
        'DETERMINER' {        	
			wrd := lookuplist(wordtype, listdbs.determiners, listdbs.mpgcounts.detcnt)!
	        wrdline << wrd
		}
        'INTERJECTION' {        	
			wrd := lookuplist(wordtype, listdbs.interjections, listdbs.mpgcounts.intcnt)!
	        wrdline << wrd
		}
        'CONJUNCTION' {
			wrd := lookuplist(wordtype, listdbs.conjunctions, listdbs.mpgcounts.conjcnt)!
	        wrdline << wrd
		}
		'PREPOSITION' {
			wrd := lookuplist(wordtype, listdbs.prepositions, listdbs.mpgcounts.prepcnt)!
	        wrdline << wrd
		}
		'ADVERB' {
			wrd := lookuplist(wordtype, listdbs.adverbs, listdbs.mpgcounts.advcnt)!
	        wrdline << wrd
		}
		' ' {
			//dunno why these are in the mpgwords CSV - suspect they are last lines of CSV file or empty rows
			continue
		}
		'' {
			//dunno why these are in the mpgwords CSV - suspect they are last lines of CSV file or empty rows
			continue
		}
		else {
			improper_poem_msg(' Non-valid word TYPE found was ${wordtype}')
			exit(8)
		}
	  }	

	}

    return wrdline
}


fn lookuplist(wordtype string, thelist structs.Mpgwords, cn int)! string {    	
	mut wrd := ''
	mut ln := 0
	ln = vlibrary.mkrndint(u32(cn))!         
    wrd = thelist.mpgwordarr[ln].theword		
	return wrd
}

// writes out to tmp file the generated poems
fn writepoems(allpoems [][]string, opath string, poem structs.Poem) bool {
   outfile := opath + vlibrary.make_random_filename('mpg', poem.poemtype, 'txt')
   mut file := os.create(outfile) or {exit(8)}   
   println(outfile)   
   for line in allpoems {   	
   	   ostr := vlibrary.clean_arr_line(line)
   	   println(ostr)
       file.write_string(' ${ostr} \n') or {exit(8)}              
   }
   defer { file.close() }

   return true   
}