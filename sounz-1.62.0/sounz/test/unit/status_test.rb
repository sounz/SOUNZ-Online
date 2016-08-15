require File.dirname(__FILE__) + '/../test_helper'

class StatusTest < Test::Unit::TestCase

  def test_models_for_status
    check_status(:contributor)
    check_status(:distinction)
    check_status(:event)
    check_status(:manifestation)
    check_status(:organisation)
    check_status(:person)
    check_status(:sample)
    check_status(:superwork)
    check_status(:venue)
    check_status(:work)
  end
  
  
  #Check that a model responds to status_id, status and that from the statuses it can be found
  def check_status(model_sym)
    klass_name = model_sym.to_s.camelize
    klass = klass_name.constantize
    
    puts "*** CLASS IS #{klass}"
    model = klass.find(:first)
    puts "*****"+model.to_s
    assert model.respond_to?('status_id')
    assert model.respond_to?('status')
    assert model.status.respond_to?(model_sym.to_s.pluralize)
  end
end
