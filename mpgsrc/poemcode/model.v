module poemcode

// mpg mpgsrc poemcode model.v

//	poemtype string 
//	nop int 
//	bpl int 
//	tmpl string 
//	meter string 
//	lpp int 
//	stnz int 
//	rhyme int 

import structs

// calls model functions to display poem model to screen
pub fn run_model(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore) bool {
    println('\nPoem model for poem type ${poem.poemtype} is as follows: \n ')
    //gotta have one of the programs in the poem module for each type
    match poem.poemtype {
		'rondeau' {
		rondeau(poem, runmode, meter_templates, listdbs) 		
		}				
		else {
			improper_poem_msg(' No poem template')
		}
	}

	return true
}

// used for various improper calls by the user
fn improper_poem_msg(localmsg string) {
	println('${localmsg}')
	expected_call := ('MPG expects to be run with a known poem template: 
	           examples: "rondeau" or "freeform" etc
	           you can set that template in the TOML file used in the call to MPG')
	println(expected_call.replace('\n\t', '\n'))
	exit(0)
}

// selects random rows from a [][] string data structure
fn select_random_rows(listname structs.Mpgwords) bool {
	println('type of passed parameter is ${typeof(listname).name}')
	println(listname)
	return true
}

// gets a random meter template line

fn get_template_line(meter_templates [][]string) []string {
   mut linemeta := []string{}
   return linemeta
}
