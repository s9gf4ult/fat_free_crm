class OfferComponent < ActiveRecord::Base
  attr_accessible :content, :name
  validates :name, :presence => true, :uniqueness => true

  sortable :by => ["name ASC", "created_at DESC", "updated_at DESC"], :default => "created_at DESC"
  has_paper_trail
end
