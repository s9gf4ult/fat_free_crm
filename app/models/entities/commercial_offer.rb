class CommercialOffer < ActiveRecord::Base
  include ContentStuff

  attr_accessible :content, :name, :contact_id, :document_template_id, :preview_file_name, :definitions
  belongs_to :contact
  belongs_to :document_template

  has_many :component_assignments, :dependent => :destroy
  has_many :offer_components, :through => :component_assignments
  has_many :emails, :as => :mediator
  has_many :tasks, :as => :asset

  validates :name, :presence => true, :uniqueness => {:scope => :contact_id}
  validates :contact_id, :presence => true

  sortable :by => ["name ASC", "created_at DESC", "updated_at DESC"], :default => "created_at DESC"

  has_paper_trail :ignore => [ :subscribed_users ]
  acts_as_commentable
  uses_user_permissions

  serialize :subscribed_users, Set

  # Discard given attachment from the contact.
  #----------------------------------------------------------------------------
  def discard!(attachment)
    if attachment.is_a?(Task)
      attachment.update_attribute(:asset, nil)
    else # Opportunities
      self.send(attachment.class.name.tableize).delete(attachment)
    end
  end

  def regenerate_content
    if self.offer_components.count > 0
      new_content = self.offer_components.map do |component|
        "\n% ======== BEGIN COMPONENT #{component.component_type}/#{component.name} ======== \n" <<
          component.content <<
          "\n% ======== END COMPONENT #{component.component_type}/#{component.name} ======== \n"
      end.join("\n")

      self.content = new_content
      self.save
    end
  end

  def component_pictures
    self.offer_components.flat_map do |oc|
      oc.my_pictures
    end
  end

end
