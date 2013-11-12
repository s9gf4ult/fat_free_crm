class DocumentTemplate < ActiveRecord::Base
  attr_accessible :content_after, :content_before, :name
end
