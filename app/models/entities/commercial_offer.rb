class CommercialOffer < ActiveRecord::Base
  include ContentStuff

  attr_accessible :content, :name, :contact_id, :document_template_id, :preview_file_name
  belongs_to :contact
  belongs_to :document_template

  has_many :component_assignments, :dependent => :destroy
  has_many :offer_components, :through => :component_assignments

  validates :name, :presence => true, :uniqueness => {:scope => :contact_id}
  validates :contact_id, :presence => true

  sortable :by => ["name ASC", "created_at DESC", "updated_at DESC"], :default => "created_at DESC"
  has_paper_trail


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
