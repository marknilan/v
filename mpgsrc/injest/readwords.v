module injest

// mpg mpgsrc injest readwords.v
import structs
import os
import encoding.csv

// gets the mpgwords loaded into memory
pub fn get_words(mpgwordspath string) structs.Mpgwords {
	mut mpgline := structs.Mpgline{}
	mut mpgwords := structs.Mpgwords{}
	content := os.read_file(mpgwordspath) or { exit(8) } // guard fname exists but no read access
	mut reader := csv.new_reader(content)
	reader.read() or { exit(8) } // skips first line assumes column headings	
	// rejects any invalid column counts - must be seven cols
	// csv fields must be exact same order as below
	for {
		line_data := reader.read() or { break }
		if line_data.len != 7 {
			continue
		}
		mpgline.wordidx = line_data[0].int()
		mpgline.theword = line_data[1]
		mpgline.sylcnt = line_data[2].int()
		mpgline.foot = line_data[3]
		mpgline.wordtype = line_data[4]
		mpgline.feet = line_data[5]
		mpgline.beatcnt = line_data[6].int()
		mpgwords.mpgwordarr << mpgline
	}

	return mpgwords
}

// gets meter (sentence) templates
pub fn getmtrtempl(mtrtmplpath string) [][]string {
	// mut meter_templates := [][]string{}
	mut meter_templates := [][]string{}
	println(mtrtmplpath)
	content := os.read_file(mtrtmplpath) or { exit(8) } // guard fname exists but no read access
	mut reader := csv.new_reader(content)
	for {
		line_data := reader.read() or { break }
		meter_templates << line_data
	}

	return meter_templates
}

// gets rhyming root data
pub fn getrhymeroots(rrdata string) structs.MpgRroots{
	mut mpgrrline := structs.MpgRrline{}
	mut mpgrroots := structs.MpgRroots{}
    content := os.read_file(rrdata) or { exit(8) } // guard fname exists but no read access
	mut reader := csv.new_reader(content)
	for {
		line_data := reader.read() or { break }
		if line_data.len != 2 {
			continue
		}
		mpgrrline.rindex = line_data[0].int()
		mpgrrline.wrdsuffix = line_data[1]
		mpgrroots.rhymearray << mpgrrline
	}
    return mpgrroots
}
