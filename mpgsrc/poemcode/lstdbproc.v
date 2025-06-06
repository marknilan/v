module poemcode

// mpg mpgsrc poemcode lstdbproc.v
import structs
import vlibrary
import math

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
	println('beats for this word are ${beats} beatmax is ${beatmax}')
	return wrd
}

// get_random_wrds given a meter template, this delivers back a string array of actual random words
fn get_random_wrds(template []string, listdbs structs.MpgListstore, beatmax int, poem structs.Poem) !([]string, int) {
	mut wrdline := []string{}
	mut wrd := ''
	mut bm := beatmax

	for wordtype in template {
		if bm < 0 {break}
		match wordtype.trim(' ') {
			'NOUN' {
				wrd = lookuplist(wordtype, listdbs.nouns, listdbs.mpgcounts.nouncnt, beatmax)!
				if bm >= 0 {
					wrdline << wrd
					bm = findbeatmax(wrdline, listdbs.nouns, bm)
				} else {
					break
				}
			}
			'VERB' {
				wrd = lookuplist(wordtype, listdbs.verbs, listdbs.mpgcounts.verbcnt, beatmax)!
				if bm >= 0 {
					wrdline << wrd
					bm = findbeatmax(wrdline, listdbs.verbs, bm)
				} else {
					break
				}
			}
			'ADJECTIVE' {
				wrd = lookuplist(wordtype, listdbs.adjectives, listdbs.mpgcounts.adjcnt,
					beatmax)!
				if bm >= 0 {
					wrdline << wrd
					bm = findbeatmax(wrdline, listdbs.adjectives, bm)
				} else {
					break
				}
			}
			'PRONOUN' {
				wrd = lookuplist(wordtype, listdbs.pronouns, listdbs.mpgcounts.proncnt,
					beatmax)!
				if bm >= 0 {
					wrdline << wrd
					bm = findbeatmax(wrdline, listdbs.pronouns, bm)
				} else {
					break
				}
			}
			'DETERMINER' {
				wrd = lookuplist(wordtype, listdbs.determiners, listdbs.mpgcounts.detcnt,
					beatmax)!
				if bm >= 0 {
					wrdline << wrd
					bm = findbeatmax(wrdline, listdbs.determiners, bm)
				} else {
					break
				}
			}
			'INTERJECTION' {
				wrd = lookuplist(wordtype, listdbs.interjections, listdbs.mpgcounts.intcnt,
					beatmax)!
				if bm >= 0 {
					wrdline << wrd
					bm = findbeatmax(wrdline, listdbs.interjections, bm)
				} else {
					break
				}
			}
			'CONJUNCTION' {
				wrd = lookuplist(wordtype, listdbs.conjunctions, listdbs.mpgcounts.conjcnt,
					beatmax)!
				if bm >= 0 {
					wrdline << wrd
					bm = findbeatmax(wrdline, listdbs.conjunctions, bm)
				} else {
					break
				}
			}
			'PREPOSITION' {
				wrd = lookuplist(wordtype, listdbs.prepositions, listdbs.mpgcounts.prepcnt,
					beatmax)!
				if bm >= 0 {
					wrdline << wrd
					bm = findbeatmax(wrdline, listdbs.prepositions, bm)
				} else {
					break
				}
			}
			'ADVERB' {
				wrd = lookuplist(wordtype, listdbs.adverbs, listdbs.mpgcounts.advcnt,
					beatmax)!
				if bm >= 0 {
					wrdline << wrd
					bm = findbeatmax(wrdline, listdbs.adverbs, bm)
				} else {
					break
				}
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

	return wrdline, bm
}

// findbeatmax reduces beatcount (to a max of zero) for the last word in a poem line
fn findbeatmax(tmpline []string, thelist structs.Mpgwords, bm int) int {
	return bm - math.max(get_beatcnt(tmpline[tmpline.len - 1], thelist), 0)
}
