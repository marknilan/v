module injest

// mpg mpgsrc injest trainwords.v
// reads and processes poem words into meter templates

import vlibrary
import structs

// gets file expected to be simple sentence format no commas, no quotes, no line gaps
pub fn readpoemlines(txtfile string, mpgwords structs.Mpgwords) [][]string {
     content := vlibrary.file_buffered_reader(txtfile)
     templates := convert_to_templates(content,mpgwords)
     return templates
}

fn convert_to_templates(content []string, mpgwords structs.Mpgwords) [][]string {
	mut templates := [][]string{}
	for line in content {
		arr := line.split(' ')		
		for wrd in arr {
			for mpgline in mpgwords.mpgwordarr {				
				println('wrd is ${wrd}')
				if mpgline.wordtype == wrd {
					println('found')
				}
			}
		}
        templates << arr 
	}	

	return templates
}
