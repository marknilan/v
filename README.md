# mpg

# this is a poetry generation application using meter, feet and beat
# english language words dictionary includes 35k+ words
# word data has the following:
#     > WORDIDX unique index of word
#     > THEWORD no hyphens eg. 'CANINE'
#     > SYLCNT sylable count  2
#     > FOOT the accented foot signature eg. 'CANINE' is '1-2'
#     > WORDTYPE NOUN for the example above
#     > FEET 'iambic' for the example above
#     > BEATCNT number of beats 
#       - eg. 'ELEGANT' is sylable count = 3 and FOOT = '3-0-0' 
#       -     WORD type in this case = ADJECTIVE  
#       -     but this word is different. It has a
#       -     beat count = 2. 1 less than its sylable count. 
#       -     That is because the word is pronounced 'L-EGANT' 
#       -     when read verbally in a poem. 
