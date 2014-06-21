require 'rubygems'

class File
  def self.sequential_read(file_path,chunk_size=nil)
    open(file_path) do |f|
      f.each_chunk(chunk_size) do |chunk|
        yield chunk
      end
    end
  end
  
  def each_chunk(chunk_size=1024)
    yield read(chunk_size) until eof?
  end  
  
end  

oldText = ARGV[1]
newText = ARGV[2]
CHUNK_SIZE = 10240000 # 10MB
p "ARGV[1] - #{oldText}"
p "ARGV[2] - #{newText}"

Dir["#{ARGV[0]}/*.csv"].each do |filename|
  p "Reading file - #{filename}"
  replaced_file = filename.gsub(/.csv/,'_replaced.csv')
  f = File.open(replaced_file,'w')
  File.sequential_read(filename,CHUNK_SIZE) do |chunk|
    chunk.each_line do |line|
      line.gsub!(oldText,newText)
      f.write line
    end  
  end
  f.close
  p "Replaced file = #{replaced_file}"
end  

#http://stackoverflow.com/questions/13849280/dealing-with-large-csv-files-20g-in-ruby

#http://books.google.co.in/books?id=bJkznhZBG6gC&pg=PA204&lpg=PA204&dq=yield+read(chunk_size)+until+eof?&source=bl&ots=AmH0e7p_RI&sig=Z7H3l6wWwj78ylLRVROgFNWDsNY&hl=en&sa=X&ei=G3qlU_vQDYS3uAT--oLYBg&ved=0CCcQ6AEwAg#v=onepage&q=yield%20read(chunk_size)%20until%20eof%3F&f=false

#http://stackoverflow.com/questions/11949714/parse-huge-file-10gb-and-write-content-in-another-one