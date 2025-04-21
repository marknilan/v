module structs

// mpg mpgsrc structs structs.v

// expected TOML form is example below
// rondeau = [{nop = 3, bpl = 5, tmpl = "mud", meter = "iambpent", lpp = 15, stnz = 3, rhyme = 4}]
// purpose: configures the poems to be modelled or generated

// Poem struct sets up poems to be modelled or generated
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

// Mpgline struct represents a line for mpgwords table 
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

// Mpgwords struct the main database (CSV in memory) of mpg
pub struct Mpgwords{
pub mut:
	mpgwordarr []Mpgline
}

// Mpgcounts struct holds the counts of all word type lists
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
    prepcnt int
    advcnt int
}

// MpgRrline Rhyming Root line of data (rhyming rule)
pub struct MpgRrline{
pub mut:
    rindex int
    wrdsuffix string
}

// MpgRroot is struct which holds Rhyming Root information in three or more 
// character prexises
pub struct MpgRroots{
pub mut:
   rhymearray []MpgRrline
}


// MpgListstore struct holds all lists as a single passable parameter
// almost like a DB schema
pub struct MpgListstore{
pub mut:
    mpgwords Mpgwords    
    nouns Mpgwords
    verbs Mpgwords
    adjectives Mpgwords
    pronouns Mpgwords
    determiners Mpgwords
    interjections Mpgwords
    conjunctions Mpgwords
    prepositions Mpgwords
    adverbs Mpgwords
    rhyme_roots MpgRroots
    mpgcounts Mpgcounts
}

// MpgTraining is a training struct used for template creation
pub struct MpgTraining{
pub mut:
    templatename string
    beat int
    templateline []string     
}

