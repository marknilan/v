module startup

// mpg mpgsrc startup config.v
// contains code used for setup of the MPG program
import toml
import structs
import vlibrary
import os
import errors

// config is the main configuration of the program. It uses the supplied TOML format file
pub fn config(cfgfile string, runmode string) structs.Poem {
	println('MPG was called in mode: ${runmode} with TOML file: ${cfgfile} \n')
	doc := toml.parse_file(cfgfile) or {
		errors.file_access_error('READ', 'TOML file structure error', cfgfile)
		exit(8)
	}
	localpoem := structs.Poem{
		poemtype: doc.value('Poem.poemtype').string()
		nop:      doc.value('Poem.nop').int()
		bpl:      doc.value('Poem.bpl').int()
		tmpl:     doc.value('Poem.tmpl').string()
		meter:    doc.value('Poem.meter').string()
		lpp:      doc.value('Poem.lpp').int()
		stnz:     doc.value('Poem.stnz').int()
		rhyme:    conv_toml_arr(doc.value('Poem.rhyme').array())
	}
	// println('poem metadata is as follows: \n${localpoem}')
	return localpoem
}

// conv_toml_arr  NOTE: I hate V toml for this type of crap - must be a better way
fn conv_toml_arr(ta []toml.Any) []int {
	mut na := []int{}
	for e in ta {
		na << e.int()
	}

	return na
}

pub fn setup_paths() !structs.MpgPaths {
	mut wrdpath := 'WARNING: missing path'
	mut tmpdir := 'WARNING missing path'
	mut templatepath := 'WARNING: missing path'
	if vlibrary.find_os() == 'Windows' {
		wrdpath = os.home_dir() + '\\projects\\v\\mpg\\words\\'
		tmpdir = 'c:\\temp\\'
		templatepath = os.home_dir() + '\\projects\\v\\mpg\\templates\\'
	} else {
		wrdpath = os.home_dir() + '/projects/v/mpg/words/'
		tmpdir = '/tmp/'
		templatepath = os.home_dir() + '/projects/v/mpg/templates/'
	}
	return structs.MpgPaths{
		wrdpath:      wrdpath
		tmpdir:       tmpdir
		templatepath: templatepath
	}
}
