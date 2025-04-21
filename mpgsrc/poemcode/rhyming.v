module poemcode

// mpg mpgsrc poemcode rhyming.v
// contains code for ryhming processing

import structs

// keep_rhymed_word gets the last word from a line ready for processdin 
// if needed on the next line, or subsequent lines
// according to meter template rules for a poem type
fn keep_rhymed_word(theline []string) string {
	return theline[theline.len-1]
}

// compare_rhymes breaks down the last word in the current processed line template
// as a suffix. I reduces the word character by character until minimum sylable length
// of (3). It does that until a close rhyming match is found. Each match is then loaded into 
// a match array. Then a random choice is made from that match array giving the rhyme index 
// which is then used to fetch the rhymed word. It is placed back on the last word of the 
// process line template before giving being passed back to the caller as a newline.
fn compare_rhymes(theline []string, lastrhyme string, listdbs structs.MpgListstore) []string {
	//mut oldsuffix := lastrhyme
    //println(oldsuffix)
    for wrd in theline {
    	println('${wrd.trim(' ')}')
    	for rhymearray in listdbs.rhyme_roots.rhymearray {	
    	   w := wrd.trim(' ')
    	   if (wrd[w.len-3..w.len] == rhymearray.wrdsuffix.trim(' ')) &&
    	      !(wrd.trim(' ') == rhymearray.wrdsuffix.trim(' ')) {
    	   	    println('matched ${w} to ${rhymearray.wrdsuffix.trim(' ')} ')
    	   } 
    	}
    }
	//mut newline := []string{}
	return theline
}

