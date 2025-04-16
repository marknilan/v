module mpgsrc

// mpg mpgsrc mpg.v

import startup
import injest
import poemcode

// runs the mpg program
pub fn runmpg() bool {
	// toml program configuration
	cfgfile, runmode := startup.read_parms()
	// type of poems to be modelled or generated
	poem := startup.config(cfgfile, runmode)
	println(poem)
	// word data injested into memory
	mpgwords := injest.get_words('/home/mark/projects/v/mpg/words/mpgwords.csv')
	// poem form meter templates
	meter_templates := injest.getmtrtempl('/home/mark/projects/v/mpg/words/meter_templates.csv')
	// splitting word data by type
	nouns, verbs, adjectives, pronouns, determiners, interjections, conjunctions := injest.makelists(mpgwords)
	// create virtual DB (lists) schema
	mut listdbs := injest.listdbs(mpgwords, nouns, verbs, adjectives, pronouns, determiners, interjections, 
		conjunctions)
	// virtual Db schema metadata
   listdbs.mpgcounts = injest.make_list_counts(listdbs)		    
	println('\n MPG word metadata is as follows \n: ${listdbs.mpgcounts}')
    if runmode.to_lower() in ['-t', 't'] {
    	injest.rwpoemtemplate('/home/mark/projects/v/mpg/words/notused/rondeautraining1.txt',mpgwords, poem)
    	println('New templates written to tmp dir mpgtemplates.txt')
    }

    if runmode.to_lower() in ['-m', 'm'] {
       poemcode.run_model(poem, runmode, meter_templates, listdbs)
    }

	if runmode.to_lower() in ['-g', 'g'] {
		println('generate here')
	}
	// poemcode.run_model(poem,runmode,meter_templates)

	return true
}

