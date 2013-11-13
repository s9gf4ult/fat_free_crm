class CommercialOffer < ActiveRecord::Base
  include ContentStuff

  attr_accessible :content, :name, :contact_id, :document_template_id, :preview_file_name
  belongs_to :contact
  belongs_to :document_template

  has_many :component_assignments
  has_many :offer_components, :through => :component_assignments

  validates :name, :presence => true, :uniqueness => {:scope => :contact_id}
  validates :contact_id, :presence => true
  validates :preview_file_name, :uniqueness => true

  sortable :by => ["name ASC", "created_at DESC", "updated_at DESC"], :default => "created_at DESC"
  has_paper_trail


  def regenerate_content
    if self.offer_components.count > 0
      new_content = self.component_assignments.map do |cas|
        cas.offer_component.content
      end.join("\n")

      t = self.document_template
      if t
        new_content = t.content_before << "\n" << new_content << "\n" << t.content_after
      end

      self.content = new_content
      self.save
    end
  end
end
