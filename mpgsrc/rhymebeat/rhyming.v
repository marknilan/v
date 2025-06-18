module rhymebeat

// mpg mpgsrc poemcode rhyming.v
// contains code for ryhming processing
import structs
import math
import vlibrary
import strings
import arrays

// compare_rhymes finds the word rhyming with the last rhyme in mpgwords List DB
// it calls functs to decrementally find rhyming sylables using phonics and soundex
pub fn compare_rhymes(mut theline []string, lastrhyme string, listdbs structs.MpgListstore) ![]string {
	mut rhymed := []string{}
	mut tl := theline.clone()
	// println('tl was ${tl}')
	wrd := lastrhyme
	// println('THE LAST WORD of the passed array WAS ${wrd}')
	mut holdarr := []string{}
	mut holdidx := 0
	// firstly capture a list of phonically similar rhymed words (using 3 suffix chars)	
	maxbk := math.min(wrd.len, 3)
	// println('maxbk = ${maxbk}')
	// gets an array of rhyme indexes matching the phonic sylables of the word
	// as per rindex, this also picks up soundex words into the list
	for rhymearray in listdbs.rhyme_roots.rhymearray {
		if wrd[wrd.len - maxbk..wrd.len] == rhymearray.wrdsuffix.trim(' ')
			&& !(wrd.trim(' ') == rhymearray.wrdsuffix.trim(' ')) {
			// 	   	  println('matched ${wrd} at index ${rhymearray.rindex.str()} to ${rhymearray.wrdsuffix.trim(' ')} ')
			holdidx = rhymearray.rindex
			break
		}
	}

	// if there are no PHONIC word matches. Disregard that approach and use the original word with ONLY soundex match
	if !(holdidx == 0) {
		holdarr = idxhunt(holdidx, wrd, listdbs)
	}

	// this searches mpgwords using the words chosen in the phonix / soundex list
	mut smpidx := 0
	for // simple loop
	{
		smpidx++
		if smpidx > holdarr.len {
			break
		} else {
			rhymed = wrdhunt(mut holdarr, listdbs)!
			ln := vlibrary.mkrndint(u32(rhymed.len))! // ERROR HERE on first iteration
			// println('replacement word is ${rhymed[ln]}')
			tl[tl.len - 1] = rhymed[ln]
			// println('last rhyme was ${lastrhyme} last word in new line is ${tl[tl.len-1]}')
		}
	}
	// loop end
	// REFACTOR CANDIDATE END	
	// mut newline := []string{}
	return tl
}

// idxhunt finds the index of a rhyming suffix using a list fetched from PHONICS and SOUNDEX
fn idxhunt(idx int, wrd string, listdbs structs.MpgListstore) []string {
	mut mtch := []string{}
	mtch << wrd
	for rhymearray in listdbs.rhyme_roots.rhymearray {
		if rhymearray.rindex == idx {
			mtch << rhymearray.wrdsuffix.trim(' ')
			//    		println('${rhymearray.wrdsuffix.trim(' ')}')
		}
	}

	return mtch
}

// wrdhunt breaks down the last word in the current processed line template
// as a suffix. It reduces the word character by character until minimum sylable length
// of (3). It does that until a close rhyming match is found. Each match is then loaded into
// a match array. Then a random choice is made from that match array giving the rhyme index
// which is then used to fetch the rhymed word. It is placed back on the last word of the
// process line template before given back to the caller as a newline.
fn wrdhunt(mut holdarr []string, listdbs structs.MpgListstore) ![]string {
	mut longest_rhyme := 0
	// gets the longest word in rhyming roots to act as a length
	// criteria for matching
	for rhymearray in listdbs.rhyme_roots.rhymearray {
		if rhymearray.wrdsuffix.trim(' ').len > longest_rhyme {
			longest_rhyme = rhymearray.wrdsuffix.trim(' ').len
		}
	}
	// find a rhyming word using rhyme_roots - if none found resort to
	// levenshtein matching.
	mut rhymed := []string{}
	mut found := true
	// countdown suffix trying the longest rhyme first eg. 7-6-5-4 etc
	for i := longest_rhyme - 1; i > 1; i -= 2 {
		found = false
		ln := math.min(vlibrary.mkrndint(u32(holdarr.len))!, i)
		arrays.rotate_right(mut holdarr, ln)
		for suffix in holdarr {
			if suffix.len == i {
				for mpgwordarr in listdbs.mpgwords.mpgwordarr {
					maxbk := math.min(mpgwordarr.theword.len, i)
					tw := mpgwordarr.theword.trim(' ')
					// if the substring matches the rhyming suffix BUT not the
					// exact whole word match then keep the word
					if tw[tw.len - maxbk..tw.len] == suffix && !(tw == suffix) {
						rhymed << tw
						found = true
						// got a rhyming word
						break
					}
				}
				// ok at this point neither (3 char min) suffix phonix nor soundex has matched
				// use a distance match instead, this is a last resort labelled with (l)
				// because the word chosen by closest distance is not necessarily same type of
				// word demanded by the original template.
				if (!found) || (rhymed.len < 2) {
					// levenshtein word distance fallback not ideal as the wordtype and / or foot
					// it chooses might not be the same as the original random unrhymed word
					closest := get_distance(suffix, listdbs)
					if !(closest == '') {
						rhymed << closest + ' (l)'
					} else {
						rhymed << suffix
					}
				}
			}
		}
	}

	return rhymed
}

// if rhyming roots fails use levenshtein distance
fn get_distance(wrd string, listdbs structs.MpgListstore) string {
	mut closest := ''
	mut best := 0.0
	for mpgwordarr in listdbs.mpgwords.mpgwordarr {
		// if !(wrd.trim(' ') == mpgwordarr.theword.trim(' ')) {
		//	  continue
		//}
		d := strings.levenshtein_distance_percentage(wrd.trim(' '), mpgwordarr.theword.trim(' '))
		if d > best && !(wrd.trim(' ') == mpgwordarr.theword.trim(' ')) {
			best = d
			// println('d was ${d}, wrd was ${wrd}, theword was ${mpgwordarr.theword}')
			closest = mpgwordarr.theword.trim(' ')
		}
	}

	return closest
}
