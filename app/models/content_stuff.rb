module ContentStuff
  extend ActiveSupport::Concern

  included do
    before_save :remove_crlf_content
  end
  
  module InstanceMethods
    def regenerate_preview_file(template)
      unless self.preview_file_name
        self.preview_file_name = generate_new_preview_filename
      end
      fn = File::join(Rails.root,
                      "public",
                      self.preview_file_name)
      puts fn
      dir = File::dirname fn
      unless File::exists? dir
        FileUtils.mkdir_p dir
      end
      
      name = File::basename fn, '.pdf'
      texfn = File::join dir, (name << ".tex")
      
      generate_tex texfn, template

      run_latex texfn
      self.save
    end
    
    protected
    def generate_new_preview_filename
      File::join("pdf",
                 self.class.to_s.pluralize,
                 self.id.to_s,
                 "output.pdf")
    end

    def generate_tex(texfile, template)
      pre = ''
      post = ''
      if template
        pre << template.content_before << "\n"
        post << template.content_after << "\n"
      end
      
      File.open texfile, 'w' do |f|
        f << pre
        f << self.content
        f << post
      end
    end

    def run_latex(texfile)
      puts "run latex, #{texfile}"
    end

    def remove_crlf_content
      self.content = self.content.gsub /\r\n?/, "\n"
    end
  end
end
