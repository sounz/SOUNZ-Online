class SqlHelper < ActiveRecord::Base


def self.sanitize(object)
  sanitize_sql(object)
end

end