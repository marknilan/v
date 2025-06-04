module poemcode

// mpg mpgsrc poemcode lstdbproc.v
import structs
import vlibrary

// lookuplist delivers a random word from a specific listdb given a word type
fn lookuplist(wordtype string, thelist structs.Mpgwords, cn int, beatmax int) !string {
	mut wrd := ''
	mut ln := 0
	// makes a random number index for selecting a word from a listdb given its
	// array length as a ceiling (cn)
	ln = vlibrary.mkrndint(u32(cn))!
	// get the random word
	wrd = thelist.mpgwordarr[ln].theword
	beats := get_beatcnt(wrd, thelist)
	println('beats for this word are ${beats}') 
	return wrd
}

// get_random_wrds given a meter template, this delivers back a string array of actual random words
fn get_random_wrds(template []string, listdbs structs.MpgListstore, beatmax int) ![]string {
	mut wrdline := []string{}
	mut wrd := ''
	for wordtype in template {
		match wordtype.trim(' ') {
			'NOUN' {
				wrd = lookuplist(wordtype, listdbs.nouns, listdbs.mpgcounts.nouncnt,beatmax)!
				wrdline << wrd
			}
			'VERB' {
				wrd = lookuplist(wordtype, listdbs.verbs, listdbs.mpgcounts.verbcnt,beatmax)!
				wrdline << wrd
			}
			'ADJECTIVE' {
				wrd = lookuplist(wordtype, listdbs.adjectives, listdbs.mpgcounts.adjcnt,beatmax)!
				wrdline << wrd
			}
			'PRONOUN' {
				wrd = lookuplist(wordtype, listdbs.pronouns, listdbs.mpgcounts.proncnt,beatmax)!
				wrdline << wrd
			}
			'DETERMINER' {
				wrd = lookuplist(wordtype, listdbs.determiners, listdbs.mpgcounts.detcnt,beatmax)!
				wrdline << wrd
			}
			'INTERJECTION' {
				wrd = lookuplist(wordtype, listdbs.interjections, listdbs.mpgcounts.intcnt,beatmax)!
				wrdline << wrd
			}
			'CONJUNCTION' {
				wrd = lookuplist(wordtype, listdbs.conjunctions, listdbs.mpgcounts.conjcnt,beatmax)!
				wrdline << wrd
			}
			'PREPOSITION' {
				wrd = lookuplist(wordtype, listdbs.prepositions, listdbs.mpgcounts.prepcnt,beatmax)!
				wrdline << wrd
			}
			'ADVERB' {
				wrd = lookuplist(wordtype, listdbs.adverbs, listdbs.mpgcounts.advcnt,beatmax)!
				wrdline << wrd
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
	}

	return wrdline
}
