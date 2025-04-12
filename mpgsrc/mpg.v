module mpgsrc

// mpgsrc mpg.v

import startup
import injest
import poemcode

//runs the mpg program
pub fn runmpg() bool {
	// toml program configuration
	cfgfile, runmode := startup.read_parms()
	// type of poems to be modelled or generated
	poem := startup.config(cfgfile,runmode)    
    mut meter_templates := []string{}       
    if runmode.to_lower() in['-g', 'g'] {
        // word data injested into memory
       mpgwords := injest.get_words('/home/mark/projects/v/mpg/words/mpgwords.csv')

       meter_templates = injest.get_meter_templates('/home/mark/projects/v/mpg/words/meter_templates.csv')
       // splitting word data by type
       nouns := injest.make_wrd_list(mpgwords,'NOUN')
       verbs := injest.make_wrd_list(mpgwords,'VERB')
       adjectives := injest.make_wrd_list(mpgwords,'ADJECTIVE')
       pronouns := injest.make_wrd_list(mpgwords,'PRONOUN')    
       determiners := injest.make_wrd_list(mpgwords,'DETERMINER')
       interjections := injest.make_wrd_list(mpgwords,'INTERJECTION')
       conjunctions := injest.make_wrd_list(mpgwords,'CONJUNCTION')
       // preserving word type counts for later
       mpgcounts := injest.make_list_counts(mpgwords, nouns, verbs,
                    adjectives, pronouns, determiners, interjections, conjunctions)
       println(mpgcounts) 
    } 
    poemcode.run_model(poem,runmode,meter_templates)      
    
    return true
}