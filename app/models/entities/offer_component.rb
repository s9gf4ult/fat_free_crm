

class OfferComponent < ActiveRecord::Base
  include ContentStuff

  attr_accessible :content, :name, :component_type, :preview_file_name, :definitions
  validates :name, :presence => true, :uniqueness => {:scope => :component_type}
  validates :component_type, :presence => true

  has_many :component_assignments, :dependent => :destroy
  has_many :commercial_offers, :through => :component_assignments
  has_many :email, :as => :mediator

  sortable :by => ["name ASC", "created_at DESC", "updated_at DESC"], :default => "created_at DESC"

  has_paper_trail :ignore => [ :subscribed_users ]
  acts_as_commentable
  uses_user_permissions

  serialize :subscribed_users, Set

  scope :of_type, lambda {|comtype| where(:component_type => comtype)}

  # select offer components which are not belong to specified commercial offer
  scope :not_belongs_to, lambda {|comoffer|
    where("not exists(select null from component_assignments
where component_assignments.offer_component_id = offer_components.id
and component_assignments.commercial_offer_id = ?)", comoffer.id)
  }

end
