module poemcode

// mpg mpgsrc poemcode beating.v
// contains code for beats processing

import structs
import vlibrary

pub fn increment_beat(beat int, beatmax int) int {
	println('increment_beat called with beat ${beat} and beatmax ${beatmax}')
	if beat < beatmax {
		return beat + 1
	} else {
		return beatmax
	}
}	

pub fn get_beatcnt(wrd string, thelist structs.Mpgwords) int {
	mut beats := 0	
	for mpgline in thelist.mpgwordarr {			  
        if mpgline.theword == wrd {
			beats = mpgline.beatcnt
			println('get_beatcnt found ${wrd} with ${beats} beats')
			break
	  }	
	}   	
	
	return beats
}

// sbhortens a word list by beat count filter
pub fn subset_by_beat(thelist structs.Mpgwords, beatmax int) !structs.Mpgwords {
	mut bn := 0
	mut newlist := structs.Mpgwords{
		mpgwordarr: []structs.Mpgline{}
	}
	for {
       bn = vlibrary.mkrndint(u32(beatmax))!
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
		
	println('subset_by_beat returning ${newlist.mpgwordarr.len} words with beatcnt = ${bn}')
	return newlist
}