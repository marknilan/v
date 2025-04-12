module poemcode

// mpgsrc poems rondeau.v

//  poemtype string 
//  nop int 
//  bpl int 
//  tmpl string 
//  meter string 
//  lpp int 
//  stnz int 
//  rhyme int 

import structs

// code for rondeau
pub fn rondeau(poem structs.Poem, runmode string, meter_templates [][]string) bool {
  if runmode.to_lower() in['m','-m'] {
     showmodel(poem)
  } else {
     
  }  
   
  return true  
}  

// displays the model for this poem
fn showmodel(poem structs.Poem) bool {
    mut lps :=  poem.lpp / poem.stnz
    mut lprinted := 1   
    for i := 0; i < poem.nop; i++ {      
      println('gen for poem ${i}')
      for j := 0; j < poem.stnz; j++ {
          println('       gen for stanza ${j}')
          for k := 0; (k < lps || lprinted == poem.lpp); k++ {              
              println('            line ${k}')
              lprinted++
          } 
      }
      
   }

   return true
}