module poemcode

// mpg mpgsrc poemcode rondeau.v

//  poemtype string 
//  nop int 
//  bpl int 
//  tmpl string 
//  meter string 
//  lpp int 
//  stnz int 
//  rhyme int 

import structs
import vlibrary

// code for rondeau
pub fn rondeau(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore) bool {

  if runmode.to_lower() in['m','-m'] {
     mut templates := []string{}
     for template in meter_templates {
        if template[0] =='"rondeau"' {
           templates << template
           println('found')
        }
     }   
     println(templates)
     showmodel(poem,templates) or {println('crap')}
  } else {
     println('generate here')
  }  
   
  return true  
}  

// displays the model for this poem
fn showmodel(poem structs.Poem, templates []string) !bool {
    mut lps :=  poem.lpp / poem.stnz
    mut lprinted := 1   
    l := templates.len
    println(l)
    ceilnum := u32(templates.len)
    for i := 0; i < poem.nop; i++ {      
      println('gen for poem ${i}')
      for j := 0; j < poem.stnz; j++ {
          println('       gen for stanza ${j}')
          for k := 0; (k < lps || lprinted == poem.lpp); k++ {                   
              ln := vlibrary.mkrndint(ceilnum)! 
              println('${ln}')
              println('           line ${k}')
              lprinted++
          } 
      }     
   }
   println(templates)

   return true
}