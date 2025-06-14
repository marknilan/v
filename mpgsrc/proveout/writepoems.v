module proveout 

// mpg mpgsrc writepoems writepoems.w

import structs
import vlibrary
import os
import errors

//writepoems writes out to tmp file the generated poems
pub fn writepoems(allpoems [][]string, outfile string, poem structs.Poem) bool {
	mut file := os.create(outfile) or { 
		errors.file_access_error('WRITE', 'MPG file access Error', outfile)
		exit(8)
		}
	for line in allpoems {
		ostr := vlibrary.clean_arr_line(line).replace('  ', ' ').to_lower().capitalize()
		println(ostr)
		file.write_string(' ${ostr} \n') or { exit(8) }
	}
	defer { file.close() }

	return true
}