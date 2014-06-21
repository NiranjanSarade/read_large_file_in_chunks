Problem Statement : Parse huge csv files (in GBs) under a directory and create corresponding new files with an old text replaced with new text.

>ruby large_file_read.rb [directory] [oldText] [newText]


For very large files, you will receive "NoMemoryError: failed to allocate memory" error.
This is the problem if a file it too big to fit into memory, and there are no known delimiters, or if the records between the delimiters are themselves too big to fit in memory. You have got no choice but to read from the file in chunks of a certain number of bytes. This is also the best way to read binary files.

Based on Ruby CookBook (page 204), a simple reader method added to the File class which is used to loop on the file based on the provided chunk size.

One more reference : http://stackoverflow.com/questions/11949714/parse-huge-file-10gb-and-write-content-in-another-one