module mpgsrc

// mpg mpgsrc mpg.v
import startup
import injest
import poemcode
import vlibrary
import os

// runmpg runs the mpg program
pub fn runmpg() bool {
	mut wrdpath := ''
	mut tmpdir := ''
	// program paths
	if vlibrary.find_os() == 'Windows' {
		wrdpath = os.home_dir() + '\\projects\\v\\words\\'
		tmpdir = 'c:\\temp\\'
	} else {
		wrdpath = os.home_dir() + '/projects/v/mpg/words/'
		tmpdir = '/tmp/'
	}
	// toml program configuration
	cfgfile, runmode := startup.read_parms()
	// type of poems to be modelled or generated
	poem := startup.config(cfgfile, runmode)
	println(poem)
	// word data injested into memory
	mpgwords := injest.get_words(wrdpath + 'mpgwords.csv')
	// poem form meter templates
	meter_templates := injest.getmtrtempl(wrdpath + 'meter_templates.csv')
	// splitting word data by type	
	nouns, verbs, adjectives, pronouns, determiners, interjections, conjunctions, prepositions, adverbs := injest.makelists(mpgwords)
	// create virtual DB (lists) schema
	mut listdbs := injest.listdbs(mpgwords, nouns, verbs, adjectives, pronouns, determiners,
		interjections, conjunctions, prepositions, adverbs)
	// store in List DB rhyming rules
	listdbs.rhyme_roots = injest.getrhymeroots(wrdpath + 'rhyme_roots.csv')
	// virtual Db schema metadata
	listdbs.mpgcounts = injest.make_list_counts(listdbs)
	println('\n MPG word metadata is as follows \n: ${listdbs.mpgcounts}')
	if runmode.to_lower() in ['-t', 't'] {
		injest.rwpoemtemplate(wrdpath + '/notused/rondeautraining1.txt', mpgwords, poem)
		println('New templates written to ${tmpdir} mpgtemplates.txt')
	}
	if runmode.to_lower() in ['-m', 'm'] {
		poemcode.run_model(poem, runmode, meter_templates, listdbs, tmpdir)
	}
	if runmode.to_lower() in ['-g', 'g'] {
		poemcode.run_generate(poem, runmode, meter_templates, listdbs, tmpdir)
	}

	return true
}
