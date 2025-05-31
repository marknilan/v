module mpgsrc

// mpg mpgsrc mpg.v
import startup
import injest
import poemcode

// runmpg runs the mpg program
pub fn runmpg() bool {
	//paths for input and output
	mpgpaths := startup.getpaths()
	println('MPG paths are as follows: \n${mpgpaths}')	
	// toml program configuration
	cfgfile, runmode := startup.read_parms()
	// type of poems to be modelled or generated
	poem := startup.config(cfgfile, runmode)	
	println(poem)
	// word data injested into memory
	//mpgwords := injest.get_words('/home/mark/projects/v/mpg/words/mpgwords.csv')
	mpgwords := injest.get_words(mpgpaths.inpath + 'mpgwords.csv')
	// poem form meter templates
	//meter_templates := injest.getmtrtempl('/home/mark/projects/v/mpg/words/meter_templates.csv')
	meter_templates := injest.getmtrtempl(mpgpaths.inpath + 'meter_templates.csv')
	// splitting word data by type	
	nouns, verbs, adjectives, pronouns, determiners, interjections, conjunctions, prepositions, adverbs := injest.makelists(mpgwords)
	// create virtual DB (lists) schema
	mut listdbs := injest.listdbs(mpgwords, nouns, verbs, adjectives, pronouns, determiners,
		interjections, conjunctions, prepositions, adverbs)	
	// store in List DB rhyming rules
	//listdbs.rhyme_roots = injest.getrhymeroots('/home/mark/projects/v/mpg/words/rhyme_roots.csv')
	listdbs.rhyme_roots = injest.getrhymeroots(mpgpaths.inpath + 'rhyme_roots.csv')
	// virtual Db schema metadata
	listdbs.mpgcounts = injest.make_list_counts(listdbs)
	println('\n MPG word metadata is as follows \n: ${listdbs.mpgcounts}')
	if runmode.to_lower() in ['-t', 't'] {
		injest.rwpoemtemplate(mpgpaths.inpath + 'notused\\rondeautraining1.txt',
			mpgwords, poem)
		println('New templates written to temp dir mpgtemplates.txt')
	}
	if runmode.to_lower() in ['-m', 'm'] {
		poemcode.run_model(poem, runmode, meter_templates, listdbs)
	}
	if runmode.to_lower() in ['-g', 'g'] {
		poemcode.run_generate(poem, runmode, meter_templates, listdbs, mpgpaths)
	}

	return true
}
