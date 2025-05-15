module injest

// mpg mpgsrc injest splitwords.v
import structs

// make_wrd_list splits mpgwords into word types
pub fn make_wrd_list(mpgwords structs.Mpgwords, wordtype string) structs.Mpgwords {
	mut newlist := structs.Mpgwords{}
	for mpgwordarr in mpgwords.mpgwordarr {
		if mpgwordarr.wordtype == wordtype {
			newlist.mpgwordarr << mpgwordarr
		}
	}
	return newlist
}

// make_list_counts counts word lists creates maximum index sizes for later loops
pub fn make_list_counts(listdbs structs.MpgListstore) structs.Mpgcounts {
	mpgcounts := structs.Mpgcounts{
		mpgcount: listdbs.mpgwords.mpgwordarr.len
		nouncnt:  listdbs.nouns.mpgwordarr.len
		verbcnt:  listdbs.verbs.mpgwordarr.len
		adjcnt:   listdbs.adjectives.mpgwordarr.len
		proncnt:  listdbs.pronouns.mpgwordarr.len
		detcnt:   listdbs.determiners.mpgwordarr.len
		intcnt:   listdbs.interjections.mpgwordarr.len
		conjcnt:  listdbs.conjunctions.mpgwordarr.len
		advcnt:   listdbs.adverbs.mpgwordarr.len
		prepcnt:  listdbs.prepositions.mpgwordarr.len
		rrcnt:    listdbs.rhyme_roots.rhymearray.len
	}	

	return mpgcounts
}
