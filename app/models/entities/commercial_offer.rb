class CommercialOffer < ActiveRecord::Base
  attr_accessible :content, :name
  belongs_to :contact

  validates :name, :presence => true, :uniqueness => {:scope => :contact_id}
  validates :contact_id, :presence => true

  sortable :by => ["name ASC", "created_at DESC", "updated_at DESC"], :default => "created_at DESC"
  has_paper_trail
end
