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
import math

// code for rondeau
pub fn rondeau(poem structs.Poem, runmode string, meter_templates [][]string, listdbs structs.MpgListstore) bool {

  if runmode.to_lower() in['m','-m'] {
     mut templates := [][]string{}     
     for template in meter_templates {
        if template[0] =='rondeau' {           
           templates << template
        }
     }   
     showmodel(poem,templates) or {println('Cant show model')}
  } else {
     println('generate here')
  }  

  return true  
}  

// displays the model for this poem
fn showmodel(poem structs.Poem, templates [][]string) !bool {
    mut lps :=  poem.lpp / poem.stnz
    mut lprinted := 1   
    // model for poems displayed  
    println('Model = "Rondeau" \n')    
    //mut refrain := []string{}
    for i := 0; i < poem.nop; i++ {      
      println('gen for poem ${i+1}')
      //model for stanzas displayed
      for j := 0; j < poem.stnz; j++ {
          println(' ')
          //model for lines per stanza displayed
          for k := 0; (k < lps || lprinted == poem.lpp); k++ {                   
              ln := vlibrary.mkrndint(u32(math.max(templates.len,1)))!              
              println('${templates[ln][2..templates[ln].len]}')                                
              lprinted++
          }
          //println('\n') 
      }     
      println('\n \n')
   }   

   return true
}