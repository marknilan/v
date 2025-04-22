module poemcode

// mpg mpgsrc poemcode rhyming.v
// contains code for ryhming processing

import structs
import math
import vlibrary

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
fn compare_rhymes(mut theline []string, lastrhyme string, listdbs structs.MpgListstore) ![]string {
	
	mut rhymed := []string{}
    mut tl := []string{}
    tl = theline.clone()    
    wrd := theline[theline.len-1].trim(' ')
    //println('wrd is ${wrd}')   
    mut holdarr := []string{}
    mut holdidx := 0
    maxbk := math.min(wrd.len,3)
    //println('maxbk = ${maxbk}')
    // gets an array of rhyme indexes matching the phonic or soundex sylables of the word
   	for rhymearray in listdbs.rhyme_roots.rhymearray {
	   if (wrd[wrd.len-maxbk..wrd.len] == rhymearray.wrdsuffix.trim(' ')) &&
   	      !(wrd.trim(' ') == rhymearray.wrdsuffix.trim(' ')) {
  // 	   	  println('matched ${wrd} at index ${rhymearray.rindex.str()} to ${rhymearray.wrdsuffix.trim(' ')} ')
          holdidx = rhymearray.rindex
          break

   	   } 
   	}
    if !(holdidx == 0) {
       holdarr = idxhunt(holdidx,wrd,listdbs)
    }
    
    mut smpidx := 0
    for // simple loop 
	{
		smpidx++				
		if smpidx > holdarr.len
		{ 
			//println('zotts')
			break 
		} else {
            rhymed = wrdhunt(holdarr,listdbs)            
            ln := vlibrary.mkrndint(u32(math.max(rhymed.len, 1)))!
            println('replacement word is ${rhymed[ln]}')
            tl[tl.len-1] = rhymed[ln]
            //println('last rhyme was ${lastrhyme} last word in new line is ${tl[tl.len-1]}')
		}
	}

	//mut newline := []string{}
	return tl
}

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

fn wrdhunt(holdarr []string, listdbs structs.MpgListstore) []string {
	mut rhymed := []string{}
    for suffix in holdarr{
    	for mpgwordarr in listdbs.mpgwords.mpgwordarr {
    		maxbk := math.min(mpgwordarr.theword.len,3)
    		tw := mpgwordarr.theword.trim(' ')
    		if tw[tw.len-maxbk..tw.len] == suffix {
    			rhymed << tw
    			//println('matched ${tw} to ${suffix} ')
    		}
    	}
    }
    
    return rhymed
}