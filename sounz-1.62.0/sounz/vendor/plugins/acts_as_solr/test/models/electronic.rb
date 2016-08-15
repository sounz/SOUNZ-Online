# Table fields for 'electronics'
# - id
# - name
# - manufacturer
# - features
# - category
# - price

class Electronic < ActiveRecord::Base
  acts_as_solr :facets => [:category, :manufacturer],
               :fields => [:name, :manufacturer, :features, :category, {:price => :range_float}]
end
