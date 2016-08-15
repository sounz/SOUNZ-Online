class Fixer
  
  #- Fix text for indentation to keep YAML happy -
  def self.indent_yaml(text, indent)
    #Save text to a temporary file
    f = File.new("temp.txt", "w")
    f.puts(text)
    f.close
    
    #now we need to read this temp file and indent it correctly
    lines = IO.readlines("temp.txt")
    result = ""
    first = true
    for line in lines
      #escape chars that cause breaks
      line.strip!
      line.gsub!("\'", "")
      
   #   line.gsub!(']' ,"']'")
   #   line.gsub!('[' , "'['")
     line.gsub!('"' , "\\x22")
   #   line.gsub!('-' , "'-'")
   #   line.gsub!(':' , "':'") # replace with colon
      #   puts line
      #for non zero lines
      if line.length > 0
        if !first
          for i in 1..indent
            result << " "
          end
        else
          first = false
        end

        result << line

        result << "\n"
        
      #mirror line breaks, as they may be separate paras
      else
          result << "\n\n"
      end
      
    end
    
    #  puts result
    
    
    return '"'+result.strip!+'"'
  end
end