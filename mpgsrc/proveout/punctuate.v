module proveout

// mpg mpgsrc proveout punctuate.v
// contains code for punctuation symbols used in the poem line
import vlibrary

// punctuate_line takes a string and randomly adds punctuation symbols to it.
// It returns the modified string with punctuation or the original string if no punctuation is added.
// It uses a random number generator to decide whether to add punctuation or not on each line.
pub fn punctuate_line(ostr string) !string {
	punc_symbols := make_punct_symbols()
	if vlibrary.is_odd(vlibrary.rnd_anynum()!) {
        punctuated := change_spaces(ostr, punc_symbols)! // punctuate the line with symbols
		// a one word line  triggers this
	    if punctuated.len < 1 {
		   return ostr
	    } else {
 		   return punctuated
        } 
	
   }  else {
		return ostr // no punctuation added
   }
}   

// make_punct_symbols returns a list of punctuation symbols used in the poem
fn make_punct_symbols() []string {
	symb := ['.', ',', '?', '!']

	return symb
}

// make_space_idx determines spaces to put punctuation marks into the line 
fn make_space_idx(ostr string) []int {
	// Find all indices of spaces in the string
	mut space_indices := []int{}
	for i, c in ostr.runes() {
		if c == ` ` {
			space_indices << i
		}
	}
	return space_indices
}

// change_spaces takes a string and a list of punctuation symbols, randomly selects a space in the string,
// and replaces it with a randomly selected punctuation symbol from the list.
fn change_spaces(ostr string, punct_symbols []string) !string {		 
	// Find all indices of spaces in the string
	mut space_indices := make_space_idx(ostr)
	if space_indices.len == 0 || ostr == ' ' {
		return ostr // No spaces found, return the original string
	} else {
		// Choose a random space index
		space_idx := vlibrary.mkrndint(u32(space_indices.len))!
		insert_pos := space_indices[space_idx]
		// Choose a random punctuation symbol
		punc_idx := vlibrary.mkrndint(u32(punct_symbols.len))!
		punc := punct_symbols[punc_idx]
		// Insert the punctuation after the chosen space
		mut runes := ostr.runes()
		runes.insert(insert_pos, punc.runes()[0])
		if !(runes.len == insert_pos) && insert_pos + 2 < runes.len {
			if punc in ['.', '?', '!'] {
				c := runes[insert_pos + 2].to_upper()
				runes[insert_pos + 2] = c
			}
		}

		return runes.string()
	}
}
