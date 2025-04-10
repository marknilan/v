module startup

import toml
import structs

// main configuration of the program here using the supplied TOML format file
pub fn config(cfgfile string) structs.Poem {	
	doc := toml.parse_file(cfgfile) or { panic(err) }	
	return structs.Poem{
		   poemtype: doc.value('Poem.poemtype').string()
	       nop: doc.value('Poem.nop').int()
	       bpl: doc.value('Poem.bpl').int()
	       tmpl: doc.value('Poem.tmpl').string()
	       meter: doc.value('Poem.meter').string()
	       lpp: doc.value('Poem.lpp').int()
	       stnz: doc.value('Poem.stnz').int()
	       rhyme: doc.value('Poem.rhyme').int()
           }
}

