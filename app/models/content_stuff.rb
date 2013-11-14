module ContentStuff
  extend ActiveSupport::Concern

  included do
    before_save :remove_crlf_content
  end
  
  module InstanceMethods
    def regenerate_preview_file(template)
      puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> "
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

      res = run_latex texfn
      self.save
      res
    end
    
    protected
    def generate_new_preview_filename
      File::join("pdf",
                 self.class.to_s.pluralize.underscore,
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
      dir = File::dirname texfile
      name = File::basename texfile
      out = `cd #{dir} && xelatex #{name}`
      if $? == 0
        false
      else
        out
      end
    end

    def remove_crlf_content
      if self.content
        self.content = self.content.gsub /\r\n?/, "\n"
      end
    end
  end
end
