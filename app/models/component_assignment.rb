class ComponentAssignment < ActiveRecord::Base
  attr_accessible :commercial_offer_id, :offer_component_id, :order_value
  belongs_to :commercial_offer
  belongs_to :offer_component
  validates :commercial_offer_id, :presence => true
  validates :offer_component_id, :presence => true, :uniqueness => {:scope => :commercial_offer_id}
  validates :order_value, :presence => true
end
