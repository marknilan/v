module injest

// mpg mpgsrc injest makedb.v
// creates struct of the word lists of MPG
import structs

// makelists splits the source data of words into word types
pub fn makelists(mpgwords structs.Mpgwords) (structs.Mpgwords, structs.Mpgwords, structs.Mpgwords, structs.Mpgwords, structs.Mpgwords, structs.Mpgwords, structs.Mpgwords, structs.Mpgwords, structs.Mpgwords ) {
	// splitting word data by type
	nouns := make_wrd_list(mpgwords, 'NOUN','WORDTYPE')
	verbs := make_wrd_list(mpgwords, 'VERB','WORDTYPE')
	adjectives := make_wrd_list(mpgwords, 'ADJECTIVE','WORDTYPE')
	pronouns := make_wrd_list(mpgwords, 'PRONOUN','WORDTYPE')
	determiners := make_wrd_list(mpgwords, 'DETERMINER','WORDTYPE')
	interjections := make_wrd_list(mpgwords, 'INTERJECTION','WORDTYPE')
	conjunctions := make_wrd_list(mpgwords, 'CONJUNCTION','WORDTYPE')
	prepositions := make_wrd_list(mpgwords, 'PREPOSITION','WORDTYPE')
	adverbs := make_wrd_list(mpgwords, 'ADVERB','WORDTYPE')
	
	return nouns, verbs, adjectives, pronouns, determiners, interjections, conjunctions, prepositions, adverbs
}

// listdbs stores all the word lists in one DB schema (vitual DB schema is lists in memory)
pub fn listdbs(mpgwords structs.Mpgwords, nouns structs.Mpgwords, verbs structs.Mpgwords, adjectives structs.Mpgwords,
	pronouns structs.Mpgwords, determiners structs.Mpgwords, interjections structs.Mpgwords,
	conjunctions structs.Mpgwords, prepositions structs.Mpgwords, adverbs structs.Mpgwords ) structs.MpgListstore {
	// this is the virtual DB schema
	mpgliststore := structs.MpgListstore{
		mpgwords:      mpgwords
		nouns:         nouns
		verbs:         verbs
		adjectives:    adjectives
		pronouns:      pronouns
		determiners:   determiners
		interjections: interjections
		conjunctions:  conjunctions
		prepositions:  prepositions		
		adverbs: adverbs
		mpgcounts:     structs.Mpgcounts{} // starts empty, updated later
	}

	return mpgliststore
}
