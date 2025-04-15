module injest

// mpg mpgsrc injest makedb.v
// creates struct of the word lists of MPG
import structs

// splits the source data of words into word types
pub fn makelists(mpgwords structs.Mpgwords) (structs.Mpgwords, structs.Mpgwords, structs.Mpgwords, structs.Mpgwords, structs.Mpgwords, structs.Mpgwords, structs.Mpgwords) {
	// splitting word data by type
	nouns := make_wrd_list(mpgwords, 'NOUN')
	verbs := make_wrd_list(mpgwords, 'VERB')
	adjectives := make_wrd_list(mpgwords, 'ADJECTIVE')
	pronouns := make_wrd_list(mpgwords, 'PRONOUN')
	determiners := make_wrd_list(mpgwords, 'DETERMINER')
	interjections := make_wrd_list(mpgwords, 'INTERJECTION')
	conjunctions := make_wrd_list(mpgwords, 'CONJUNCTION')
	return nouns, verbs, adjectives, pronouns, determiners, interjections, conjunctions
}

// stores all the word lists in one DB schema (vitual DB schema is lists in memory)
pub fn listdbs(mpgwords structs.Mpgwords, nouns structs.Mpgwords, verbs structs.Mpgwords, adjectives structs.Mpgwords,
	pronouns structs.Mpgwords, determiners structs.Mpgwords, interjections structs.Mpgwords,
	conjunctions structs.Mpgwords) structs.MpgListstore {
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
		mpgcounts:     structs.Mpgcounts{} // starts empty, updated later
	}

	return mpgliststore
}
