#!/usr/bin/ruby
require 'sentence_reader.rb'
require 'paragraph_reader.rb'
require 'fixer_yaml'


#Use to create random subjects
rsg = SentenceReader::new
rsg.loadfile('musical-prose.txt',10000000)

#Used to create random paragraphs
rpg = ParagraphReader::new
rpg.loadfile("musical-prose.txt", 10000000)


puts '<%time_now = Time.now%>'
for i in 1..1000
puts '<%updated_at = time_now - rand(31536000)'
puts 'created_at = updated_at - rand(31536000)%>'
  subject = Fixer.indent_yaml(rsg.random_sentence,2)
  paras = Fixer.indent_yaml(rpg.random_paragraphs(4),24)
 # paras = rpg.random_paragraphs(4)
 #
  puts "comm_#{i}:
    communication_id: #{i}
    communication_type_id: 1
    communication_method_id: 1
    communication_agent_class: P
    communication_subject: #{subject}
    communication_note: #{paras}
    priority: 1
    status: o
    created_at: <%=created_at.strftime('%Y-%m-%d')%>
    updated_at: <%=updated_at.strftime('%Y-%m-%d')%>
    
    "
end