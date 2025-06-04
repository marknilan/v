module poemcode

// mpg mpgsrc poemcode beating.v
// contains code for beats processing

import structs

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