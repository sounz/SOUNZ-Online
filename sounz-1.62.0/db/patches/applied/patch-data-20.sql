-- Do the following
-- Alter the VEER table to allow events to be deleted from expressions and vice versa

begin;

update  valid_entity_entity_relationships set user_maintainable = 't' where ruby_method_name = 'happening_expressions';
update  valid_entity_entity_relationships set user_maintainable = 't' where ruby_method_name = 'events_happening_at';


commit;