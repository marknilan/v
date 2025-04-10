module structs

// expected TOML form is example below
// rondeau = [{nop = 3, bpl = 5, tmpl = "mud", meter = "iambpent", lpp = 15, stnz = 3, rhyme = 4}]
// purpose: configures the poems to be modelled or generated

pub struct Poem {
pub mut: 
	poemtype string
	nop int
	bpl int
	tmpl string
	meter string
	lpp int
	stnz int
	rhyme int
}


