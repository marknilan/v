module injest

// mpgsrc injest splitwords.v

import structs

// splits mpgwords into word types
pub fn make_wrd_list (mpgwords structs.Mpgwords,wordtype string) []structs.Mpgline {	
	//mut newlist := []structs.Mpgwords{}
	mut newlist := []structs.Mpgline{}
    for mpgwordarr in mpgwords.mpgwordarr {
       if mpgwordarr.wordtype == wordtype {
       	  newlist << mpgwordarr
       }

    }
	return newlist
}

// counts word lists creates maximum index sizes for later loops
pub fn make_list_counts (mpgwords structs.Mpgwords, nouns []structs.Mpgline, 
	verbs []structs.Mpgline, adjectives []structs.Mpgline, pronouns []structs.Mpgline, 
	determiners []structs.Mpgline, interjections []structs.Mpgline,
	conjunctions []structs.Mpgline) structs.Mpgcounts {
	// struct
    mpgcounts := structs.Mpgcounts{
    	mpgcount: mpgwords.mpgwordarr.len
        nouncnt: nouns.len
        verbcnt: verbs.len
        adjcnt: adjectives.len
        proncnt: pronouns.len
        detcnt: determiners.len
        intcnt: interjections.len
        conjcnt: conjunctions.len        
    }

	return mpgcounts
}



