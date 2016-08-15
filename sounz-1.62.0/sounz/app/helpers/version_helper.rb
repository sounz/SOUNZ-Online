class VersionHelper
  

 
 def self.load_text_from_file_if_exists(filepath)
   result = ""
   if File.exist?(filepath)
     begin
         file = File.new(filepath, "r")
         while (line = file.gets)
            result << line
            result << "\n"
         end
         file.close
     rescue => err
         result = "An error occurred in processing this directive"
     end
     
   end
   result
 end
 
 DEBIAN_VERSION = VersionHelper.load_text_from_file_if_exists('/etc/sounz/sounz.version')
 SUBVERSION_REVISION = VersionHelper.load_text_from_file_if_exists('/etc/sounz/sounz.svn')
 CHANGE_NOTES = VersionHelper.load_text_from_file_if_exists('/etc/sounz/sounz.changes')
 
 
 
  
end