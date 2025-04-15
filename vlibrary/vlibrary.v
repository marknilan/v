module vlibrary

// Common reusuable (between apps) vlang code library

import os
import v.pref
import io
import time
import rand
import rand.seed
import rand.pcg32

// generic error handler
// call like this //     vlibrary.app_error('Reason for the error', return code (int), 'what the program will now do')
// NEEDS error native message handling
  
pub fn app_error(error_type string, rc int, end_message string) {
      eprintln('\n rc=${rc} ${error_type} ${end_message}')
      exit(rc)
}

// returns a small file as a continuous string
pub fn file_small_reader(filename string) string { 
    content := os.read_file(filename) or {''}
    if content.len < 1 {app_error('${filename} exists but is empty',8,' -> dlexu terminating')}
    return content
}

// file reader used for sampling files - line by line to string array, with limiter
pub fn file_reader_sample(filename string, samplesize int) [] string {
    mut content := []string{}
    mut linecounter := 0
    mut file := os.open(filename) or {exit(8)}
    defer { file.close() }   
    mut r := io.new_buffered_reader(reader: file)
    for {
        line := r.read_line() or { break }
        linecounter +=1
        if linecounter <= samplesize {
            content << line   
        }  
        else
            {break}

    }
    if content.len == 0 {app_error('${filename} was read but result = 0 bytes',8,' -> dlexu terminating')}
    return content
}    

// file reader used for large files - line by line to string array
// NEEDS CHANNEL INVESTIGATION
pub fn file_buffered_reader(filename string) [] string {
    mut content := []string{}
    mut file := os.open(filename) or {exit(8)}
    mut r := io.new_buffered_reader(reader: file)
    for {
        line := r.read_line() or { break }
        content << line
    }
    defer {file.close()}
    if content.len == 0 {app_error('${filename} was read but result = 0 bytes',8,' -> dlexu terminating')}
return content
}

// finds the OS the v program is executing on 

// gets OS type of execution host
  pub fn find_os() string {
     return pref.get_host_os().str()
  }

// writes any file to path using  array of strings
fn writefile_from_array(outarray [] u8, opath string) bool {
    mut file := os.create(opath) or {exit(0)}
    for line in outarray {
        file.write_string(' ${line} \n') or {exit(8)}
    }    
    defer { file.close() }
    return true
}

// creates a filename based on system id passed as parm and time value
// filename created template example is '[system id]_[base file name]_[year]-[month]-[day][nnnnnn].csv'
// eg. 'mysystem_myfile_2024-03-09073630.csv'
pub fn make_random_filename(sysid string, outfile string,ext string) string {
   fname := outfile.replace(os.file_ext(outfile),'')    
   return '${sysid}_${fname}_${time.now().str().replace_each([' ','',':',''])}.${ext}'
}

// check if any number is odd
pub fn is_odd(n int) bool {
    mut result := true
    if (n % 2) == 0 { 
       result = false 
    } 
    return result
}

//confirm user dir and that it is writeable
pub fn chk_user_hometemp() bool {   
   mut hd := os.home_dir()
   os.ensure_folder_is_writable(hd) or {return false}   
   return true
}

//generates a random integer number below a ceiling

pub fn mkrndint(ceilnum u32) !int {
    // Initialise the generator struct (note the `mut`)
    mut rng := &rand.PRNG(pcg32.PCG32RNG{})
    // Seed the generator
    rng.seed(seed.time_seed_array(pcg32.seed_len))
    n := rng.u32n(ceilnum)!
    println('hello')
    return int(n)
}







