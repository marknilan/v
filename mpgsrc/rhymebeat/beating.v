module rhymebeat

// mpg mpgsrc rhymebeat beating.v
// contains code for beats processing

import structs
import vlibrary
import math
//import structs 

// shortens a word list by beat count filter
pub fn subset_by_beat(thelist structs.Mpgwords, beatmax int) !structs.Mpgwords {
	mut bn := 0
	mut newlist := structs.Mpgwords{
		mpgwordarr: []structs.Mpgline{}
	}
	for {
       bn = math.max(vlibrary.mkrndint(u32(beatmax))!,1)
	   println('bn is calc as ${bn} for beatmax ${beatmax}')
	   for mpgline in thelist.mpgwordarr {
		   if mpgline.beatcnt == bn {
			  newlist.mpgwordarr << mpgline
		   }
	   }
	   if newlist.mpgwordarr.len > 0 {
		   break
	   }   
	}
		
	//println('subset_by_beat returning ${newlist.mpgwordarr.len} words with beatcnt = ${bn}')
	return newlist
}

/*
pub fn subset_by_foot(wrd string, wordtype string, listdbs structs.MpgListstore, poem structs.Poem) structs.Mpgwords {
	// find the word type
	mut wordtype := ''
	mut newlist := structs.Mpgwords{
		mpgwordarr: []structs.Mpgline{}
	}

    // subset using just this type of word 
	match wordtype.trim(' ') {
			'NOUN' {				
				newlist = listdbs.nouns
				newlist = 
			}
			'VERB' {
				newlist = listdbs.verbs
			}
			'ADJECTIVE' {
				newlist = listdbs.adjectives
			}
			else {
				newlist = listdbs.Mpgwords 
			}
	}		


    mut nl := structs.Mpgwords{
		mpgwordarr: []structs.Mpgline{}
	}


    
	//checking is poem requires last word of line to be of particular foot
	if poem.poemtype = 'iambic' {
	    for mpgwordarr in newlist.mpgwordarr {
		    if mpgwordarr.foot == 'iambic' {
	           nl.mpgwordarr << mpgwordarr
		    }
	
	    }		
	}	
 		
	
}
*/
