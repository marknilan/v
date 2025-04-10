module startup

// mpgsrc startup config.v

import toml
import structs

// main configuration of the program here using the supplied TOML format file
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
	       rhyme: doc.value('Poem.rhyme').int()
           }    
	println('poem metadata is as follows: \n${localpoem}')       
	return localpoem
}


