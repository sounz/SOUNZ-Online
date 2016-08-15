module FrbrDeletionHelper
  
  # Get a list of the items that will be deleted with this manifestation
  def self.objects_to_delete_for_manifestation(manifestation)
    man_id = manifestation.manifestation_id
    n_items = Item.count(:all, :conditions => ["manifestation_id = ?", man_id])
    n_man_rel = ManifestationRelationship.count(:all, :conditions => ["manifestation_id = ?", man_id])
    n_exam_set_works = ExamSetWork.count(:all, :conditions => ["manifestation_id = ?", man_id])
    n_man_att = ManifestationAttachment.count(:all, :conditions => ["manifestation_id = ?", man_id])
    n_exp_man = ExpressionManifestation.count(:all, :conditions => ["manifestation_id = ?", man_id])
    n_man_acc_rights = ManifestationAccessRight.count(:all, :conditions => ["manifestation_id = ?", man_id])
 
    result = {
      :manifestations => 1,
      :items => n_items,
      :manifestation_relationships => n_man_rel,
      :exam_set_works => n_man_att,
      :manifestation_attachments => n_man_att,
      :expression_manifestation_links => n_exp_man,
      :manifestation_access_rights => n_man_acc_rights
    }
    
    result
  end
  
  # Get a list of the items that will be deleted with this expression
  def self.objects_to_delete_for_expression(expression)
    id = expression.expression_id
    n_rel = ExpressionRelationship.count(:all, :conditions => ["expression_id = ?", id])
    n_eve_exp = expression.number_of_events_happening_at
    n_exp_man = ExpressionManifestation.count(:all, :conditions => ["expression_id = ?", id])
    n_lang = ExpressionLanguage.count(:all, :conditions => ["expression_id = ?", id])
    n_acc_rights = ExpressionAccessRight.count(:all, :conditions => ["expression_id = ?", id])
  
    result = {
      :expressions => 1,
      :expression_relationships => n_rel,
      :expression_manifestation_links => n_exp_man,
      :access_rights => n_acc_rights,
      :expression_language_links => n_lang,
      :expression_event_links => n_eve_exp
    }
    
    result
  end
  

  
  
  #Render text/html for the javascript popup in a nice way
  def self.convert_count_hash_for_popup(count_hash)
    result = "If you click OK the following will be deleted:"
    for key in count_hash.keys
      result << "\n"
      result << key.to_s
      result << " ("
      result << count_hash[key].to_s
      result << ")"
    end
    
    result
  end
end