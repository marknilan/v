module injest

// mpg mpgsrc injest trainwords.v
// reads and processes poem words into meter templates

import vlibrary
import structs
import os

// gets file expected to be simple sentence format no commas, no quotes, no line gaps
pub fn rwpoemtemplate(txtfile string, mpgwords structs.Mpgwords, poem structs.Poem) []structs.MpgTraining {
     content := vlibrary.file_buffered_reader(txtfile)
     templates := convert_to_templates(content,mpgwords,poem)

     return templates
}

// creates templates and writes the file to tmp for manual import yo meter_templates
fn convert_to_templates(content []string, mpgwords structs.Mpgwords, poem structs.Poem) []structs.MpgTraining {
		
	mut templates := []structs.MpgTraining{}
	for line in content {
		mut mpgtraining := structs.MpgTraining{}
   	     mpgtraining.templatename = poem.poemtype
	     mpgtraining.beat = poem.bpl
		arr := line.split(' ')	
		mut wrds := []string{}	
		for wrd in arr {
			for mpgline in mpgwords.mpgwordarr {				
				if mpgline.theword.trim(' ') == wrd.trim(' ') {
				   wrds << mpgline.wordtype.trim(' ') 	
				}
			}			
		}
           mpgtraining.templateline = wrds
          templates << mpgtraining
	}
	println(templates)	
     writetemplates(templates, '/tmp/mpgtemplates.txt')

	return templates
}

// writes out to tmp file trining templates for meter_templates
fn writetemplates(templates []structs.MpgTraining, opath string) bool {
    mut file := os.create(opath) or {exit(8)}    
    for mpgtraining in templates {
    	mut ostr := '${mpgtraining.templatename}' + ',' + '${mpgtraining.beat.str()}' + ','
        ostr = ostr.trim_space_left() + vlibrary.clean_arr_line(mpgtraining.templateline)
        //ostr = ostr + '${mpgtraining.templateline.str()}'   
        //ostr = ostr.replace('[','')     
        //ostr = ostr.replace(']','')
        //ostr = ostr.replace("'",'')
        file.write_string(' ${ostr} \n') or {exit(8)}
    }    
    defer { file.close() }
    return true    
}

