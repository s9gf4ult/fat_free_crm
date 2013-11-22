class DocumentTemplate < ActiveRecord::Base
  attr_accessible :content_after, :content_before, :name, :program_name
  validates :name, :presence => true, :uniqueness => true
  validates :program_name, :presence => true
end
