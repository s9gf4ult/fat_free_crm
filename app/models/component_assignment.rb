class ComponentAssignment < ActiveRecord::Base
  # attr_accessible :commercial_offer_id, :offer_component_id
  belongs_to :commercial_offer
  belongs_to :offer_component
  validates :commercial_offer_id, :presence => true
  validates :offer_component_id, :presence => true, :uniqueness => {:scope => :commercial_offer_id}
end
