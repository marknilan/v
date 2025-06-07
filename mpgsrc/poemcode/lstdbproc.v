module poemcode

// mpg mpgsrc poemcode lstdbproc.v
import structs
import vlibrary

// lookuplist delivers a random word from a specific listdb given a word type
fn lookuplist(wordtype string, thelist structs.Mpgwords, cn int, beatmax int) !(string, int) {
	mut wrd := ''
	mut ln := 0
	
	//shorten the list by just looking at beat counts randomly selected
     tl := poemcode.subset_by_beat(thelist, beatmax)!
	
	// makes a random number index for selecting a word from a listdb given its
	// array length as a ceiling 
	 
    ln = vlibrary.mkrndint(u32(tl.mpgwordarr.len))!

	//ln = vlibrary.mkrndint(u32(cn))!
	// get the random word
	wrd = tl.mpgwordarr[ln].theword
	beats := tl.mpgwordarr[ln].beatcnt
	bm := beatmax - beats
	//println('beats for this word ${wrd} are ${beats} beatmax is now ${bm}')

	return wrd, bm
}

// get_random_wrds given a meter template, this delivers back a string array of actual random words
fn get_random_wrds(template []string, listdbs structs.MpgListstore, beatmax int, poem structs.Poem) !([]string, int) {
	mut wrdline := []string{}
	mut wrd := ''
	mut bm := beatmax
	for wordtype in template {
		match wordtype.trim(' ') {
			'NOUN' {
				wrd, bm = lookuplist(wordtype, listdbs.nouns, listdbs.mpgcounts.nouncnt,bm)!
			}
			'VERB' {
				wrd, bm = lookuplist(wordtype, listdbs.verbs, listdbs.mpgcounts.verbcnt,bm)!
			}
			'ADJECTIVE' {
				wrd, bm = lookuplist(wordtype, listdbs.adjectives, listdbs.mpgcounts.adjcnt,bm)!
			}
			'PRONOUN' {
				wrd, bm = lookuplist(wordtype, listdbs.pronouns, listdbs.mpgcounts.proncnt,bm)!
			}
			'DETERMINER' {
				wrd, bm = lookuplist(wordtype, listdbs.determiners, listdbs.mpgcounts.detcnt,bm)!
			}
			'INTERJECTION' {
				wrd, bm = lookuplist(wordtype, listdbs.interjections, listdbs.mpgcounts.intcnt,bm)!
			}
			'CONJUNCTION' {
				wrd, bm = lookuplist(wordtype, listdbs.conjunctions, listdbs.mpgcounts.conjcnt,bm)!
			}
			'PREPOSITION' {
				wrd, bm = lookuplist(wordtype, listdbs.prepositions, listdbs.mpgcounts.prepcnt,bm)!
			}
			'ADVERB' {
				wrd, bm = lookuplist(wordtype, listdbs.adverbs, listdbs.mpgcounts.advcnt,bm)!
			}
			' ' {
				// dunno why these are in the mpgwords CSV - suspect they are last lines of CSV file or empty rows		
				continue
			}
			'' {
				// dunno why these are in the mpgwords CSV - suspect they are last lines of CSV file or empty rows
				continue
			}
			else {
				improper_poem_msg(' Non-valid word TYPE found was ${wordtype}')
				exit(8)
			}
		}
		wrdline << wrd
		// ok we've exhaused the beats for this line - then exit.
		if bm < 0 {
			//println('I am breaking')
			break
		}
	}

	return wrdline, bm
}

