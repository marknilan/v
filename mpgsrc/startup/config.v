module startup

// mpg mpgsrc startup config.v

import toml
import structs

import vlibrary

// config is the main configuration of the program. It uses the supplied TOML format file
pub fn config(cfgfile string,runmode string) structs.Poem {	
	println('MPG was called in mode: ${runmode} with TOML file: ${cfgfile} \n')
	doc := toml.parse_file(cfgfile) or { panic(err) }	
	localpoem := structs.Poem{
		   poemtype: doc.value('Poem.poemtype').string()
	       nop: doc.value('Poem.nop').int()
	       bpl: doc.value('Poem.bpl').int()
	       tmpl: doc.value('Poem.tmpl').string()
	       meter: doc.value('Poem.meter').string()
	       lpp: doc.value('Poem.lpp').int()
	       stnz: doc.value('Poem.stnz').int()
	       rhyme: conv_toml_arr(doc.value('Poem.rhyme').array())	       
           }    	           
	//println('poem metadata is as follows: \n${localpoem}') 
	
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

pub fn getpaths() structs.MpgPaths {

    mut inp := ''
	mut oup := ''
    os := vlibrary.find_os()
	println('os is ${os}')
	if os == 'Windows' {
		inp = 'c:\\users\\mando\\projects\\v\\words\\' 
		oup = 'c:\\temp\\' 
	} else {
		   inp = '/home/mark/projects/v/mpg/words/'
		   oup = '/tmp/'
	       }
	mpgpaths := structs.MpgPaths{
	    inpath: inp
	    outpath: oup
		}
	
	return mpgpaths
}

