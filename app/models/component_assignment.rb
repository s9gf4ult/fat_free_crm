class ComponentAssignment < ActiveRecord::Base
  attr_accessible :commercial_offer_id, :offer_component_id, :order_value
  belongs_to :commercial_offer
  belongs_to :offer_component
  validates :commercial_offer_id, :presence => true
  validates :offer_component_id, :presence => true, :uniqueness => {:scope => :commercial_offer_id}
  validates :order_value, :presence => true

  default_scope order(:order_value)

  def move_up
    idx = self.component_position
    if idx > 0
      @component_assignments[idx-1], @component_assignments[idx] =
        @component_assignments[idx], @component_assignments[idx-1]
      @component_assignments.each_with_index do |c, idx|
        c.order_value = idx
        c.save
      end
    end
  end

  def move_down
    idx = self.component_position
    if idx < @component_assignments.length - 1
      @component_assignments[idx+1], @component_assignments[idx] =
        @component_assignments[idx], @component_assignments[idx+1]
      @component_assignments.each_with_index do |c, idx|
        c.order_value = idx
        c.save
      end
    end
  end

  def component_position
    @commercial_offer = self.commercial_offer
    @component_assignments = @commercial_offer.component_assignments.all
    @component_assignments.index {|c| c.id == self.id}
  end
end
