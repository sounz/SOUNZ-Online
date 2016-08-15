require 'erb'


def delete_relationships(source_frbr_class_sym)
  clause1 = ERB.new <<-EOF
  select relationship_id from <%=source_frbr_class_sym%>_relationships where <%=source_frbr_class_sym%>_id in (
  	select <%=source_frbr_class_sym%>_id from <%=source_frbr_class_sym%>s where <%=source_frbr_class_sym%>_title ilike 'Delete%'
   );
  EOF
  
  clause = clause1.result(binding)
  
  classes = [:concept, :role, :expression, :manifestation, :event, :distinction_instance, :resource,
      :superwork, :work]
      
      puts classes.length
      
  classes.delete(source_frbr_class_sym)
     puts classes.length
  classes = classes + [source_frbr_class_sym]
     puts classes.length

      
  for frbr_class in classes
      if frbr_class != source_frbr_class_sym

        template = ERB.new <<-EOF
            delete from <%=frbr_class%>_relationships where relationship_id in (
            <%=clause%>
            )
        EOF

        puts template.result(binding)

      end
  end
  
  puts "--\n\n\n\n\n\n\n"



end


delete_relationships(:manifestation)
delete_relationships(:work)
delete_relationships(:superwork)
