module injest

// mpg mpgsrc injest makedb.v
// creates struct of the word lists of MPG
import structs

pub fn makelists(mpgwords structs.Mpgwords) 
    ([]structs.Mpgline, []structs.Mpgline, []structs.Mpgline,
	[]structs.Mpgline, []structs.Mpgline, []structs.Mpgline,
	[]structs.Mpgline)
{
    // splitting word data by type
	nouns := injest.make_wrd_list(mpgwords, 'NOUN')
	verbs := injest.make_wrd_list(mpgwords, 'VERB')
	adjectives := injest.make_wrd_list(mpgwords, 'ADJECTIVE')
	pronouns := injest.make_wrd_list(mpgwords, 'PRONOUN')
	determiners := injest.make_wrd_list(mpgwords, 'DETERMINER')
	interjections := injest.make_wrd_list(mpgwords, 'INTERJECTION')
	conjunctions := injest.make_wrd_list(mpgwords, 'CONJUNCTION')
    return nouns, verbs, adjectives, pronouns, determiners, interjections, conjunctions
}

pub fn listdbs(mpgwords [][]string, nouns [][]string, verbs [][]string, adjectives [][]string,
	pronouns [][]string, determiners [][]string, interjections [][]string,
	conjunctions [][]string) structs.MpgListstore {
	mpgliststore := structs.MpgListstore{
		mpgwords:      mpgwords
		nouns:         nouns
		verbs:         verbs
		adjectives:    adjectives
		pronouns:      pronouns
		determiners:   determiners
		interjections: interjections
		conjunctions:  conjunctions
	}

	return mpgliststore
}

