

class OfferComponent < ActiveRecord::Base
  include ContentStuff

  attr_accessible :content, :name, :component_type, :preview_file_name
  validates :name, :presence => true, :uniqueness => true
  validates :component_type, :presence => true

  has_many :component_assignments
  has_many :commercial_offers, :through => :component_assignments

  sortable :by => ["name ASC", "created_at DESC", "updated_at DESC"], :default => "created_at DESC"
  has_paper_trail

  scope :of_type, lambda {|comtype| where(:component_type => comtype)}

  # select offer components which are not belong to specified commercial offer
  scope :not_belongs_to, lambda {|comoffer|
    where("not exists(select null from component_assignments
where component_assignments.offer_component_id = offer_components.id
and component_assignments.commercial_offer_id = ?)", comoffer.id)
  }

end
