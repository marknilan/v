module structs

// mpgsrc structs structs.v

// expected TOML form is example below
// rondeau = [{nop = 3, bpl = 5, tmpl = "mud", meter = "iambpent", lpp = 15, stnz = 3, rhyme = 4}]
// purpose: configures the poems to be modelled or generated

// sets up poems to be modelled or generated
pub struct Poem {
pub mut: 
	poemtype string @[required]
	nop int @[required]
	bpl int @[required]
	tmpl string @[required]
	meter string @[required]
	lpp int @[required]
	stnz int @[required]
	rhyme int @[required]
}

// represents a line for mpgwords table 
// below (taken from CSV line)
pub struct Mpgline {
pub mut:	
	wordidx int 
	theword string 
	sylcnt int 
    foot string 
    wordtype string 
    feet string 
    beatcnt int 
}

//the main database (CSV in memory) of mpg
pub struct Mpgwords{
pub mut:
	mpgwordarr []Mpgline
}

//holds the counts of all word type lists
pub struct Mpgcounts{
pub mut:
    mpgcount int
    nouncnt int
    verbcnt int
    adjcnt int
    proncnt int
    detcnt int
    intcnt int
    conjcnt	int
}

