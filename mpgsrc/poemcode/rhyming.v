module poemcode


// mpg mpgsrc poemcode rhyming.v
// contains code for ryhming processing

// keep_rhymed_word gets the last word from a line ready for processdin 
// if needed on the next line, or subsequent lines
// according to meter template rules for a poem type
fn keep_rhymed_word(theline []string) string {
	return theline[theline.len-1]
}

fn compare_rhymes(theword string, lastrhyme string) string {
	mut newrhyme := ' '
	return newrhyme 
}

