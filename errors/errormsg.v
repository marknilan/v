module errors

// mpg errors errormsg.v

// improper_parm_msg used for error conditions of various improper calls by the user
pub fn improper_parm_msg(localmsg string) {
	println('${localmsg}')
	expected_call := ('MPG expects to be run with like this: 
	           mpg -m pathtoconfigfile/tomlfile.toml (to Model poetry)
	           mpg -g pathtoconfigfile/tomlfile.toml (to Generate poetry)
	           mpg -t pathtoconfigfile/tomlfile.toml (to train MPG)')

	println(expected_call.replace('\n\t', '\n'))
	exit(0)
}
// file_access_error used for various file access errors by the user
pub fn file_access_error(acctyp string, localmsg string, filename string) {
    println('${localmsg}')
	mut cnj := 'from'
	if acctyp == 'WRITE' {
		cnj = 'to'   
	}
	file_access := ('MPG cannot ${acctyp} ${cnj} ${filename}
	           Check the path, the name and the structure of the file')	           
	println(file_access.replace('\n\t', '\n'))	

}

// improper_poem_msg used for various improper calls by the user
// NOTE: used by GEN and MODEL
pub fn improper_poem_msg(localmsg string) {
	println('${localmsg}')
	expected_call := ('MPG expects to be run with a known poem template: 
	           examples: "rondeau" or "freeform" etc
	           you can set that template in the TOML file used in the call to MPG')
	println(expected_call.replace('\n\t', '\n'))
	exit(0)
}
