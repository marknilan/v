//mpgsrc is the MPG application specific V language mainline
module mpgsrc

// mpg mpgsrc mpg.v
import startup // all things parm and config
import injest // all things incoming data
import poemcode // all things poem generation

//runmpg runs the mpg program
pub fn runmpg() !bool {
	// paths for program
	mpgpaths := startup.setup_paths()! 
	println('\nMPG program paths are as follows \n: ${mpgpaths}')
	// toml program configuration
	cfgfile, runmode := startup.read_parms()
	// type of poems to be modelled or generated
	poem := startup.config(cfgfile, runmode)
	println('\nMPG Poem Poem metadata is as follows \n: ${poem}')
	// word data injested into memory
	mpgwords := injest.get_words(mpgpaths.wrdpath + 'mpgwords.csv')
	// poem form meter templates
	meter_templates := injest.getmtrtempl(mpgpaths.wrdpath + 'meter_templates.csv')
	// splitting word data by type	
	nouns, verbs, adjectives, pronouns, determiners, interjections, conjunctions, prepositions, adverbs := injest.makelists(mpgwords)
	// create virtual DB (as lists in memory) in essence a pseudo DB schema
	mut listdbs := injest.listdbs(mpgwords, nouns, verbs, adjectives, pronouns, determiners,
		interjections, conjunctions, prepositions, adverbs)
	// store in List DB the rhyming rules
	listdbs.rhyme_roots = injest.getrhymeroots(mpgpaths.wrdpath + 'rhyme_roots.csv')
	// strore the virtual List DB schema metadata
	listdbs.mpgcounts = injest.make_list_counts(listdbs)
	println('\nMPG word metadata is as follows \n: ${listdbs.mpgcounts}')
	// trains the models
	if runmode.to_lower() in ['-t', 't'] {
		injest.rwpoemtemplate(mpgpaths.wrdpath + '/notused/rondeautraining1.txt', mpgwords, poem)
		println('New templates written to ${mpgpaths.tmpdir} mpgtemplates.txt')
	}
	// displays models
	if runmode.to_lower() in ['-m', 'm'] {
		poemcode.run_model(poem, runmode, meter_templates, listdbs, mpgpaths.tmpdir)
	}
	// generates poems from models
	if runmode.to_lower() in ['-g', 'g'] {
		poemcode.run_generate(poem, runmode, meter_templates, listdbs, mpgpaths.tmpdir)
	}

	return true
}
