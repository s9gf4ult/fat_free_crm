module ContentStuff
  extend ActiveSupport::Concern

  included do
    include ContentHelper
    before_save :remove_crlf_content
    after_destroy :remove_files
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

      res = run_latex texfn
      self.save
      res
    end

    def my_pictures
      mydir = File::join(Rails.root,
                         'public',
                         thing_pictures_path(self))
      if File::exists? mydir
        (Dir::entries mydir).find_all do |fn|
          # puts "#{fn} - #{File::directory?(fn)}"
          not File::directory?(File::join(mydir, fn))
        end.map do |fn|
          File::join("/", thing_pictures_path(self), fn)
        end
      else
        []
      end
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

      pubpath = File::join(Rails.root, 'public', '/')

      File.open texfile, 'w' do |f|
        f << pre
        f << "\n\\graphicspath\{ \{#{pubpath}\} \}\n"
        f << self.content
        f << post
      end
    end

    def run_latex(texfile)
      dir = File::dirname texfile
      name = File::basename texfile
      texcmd = "xelatex -halt-on-error \"#{name}\""
      out = `cd "#{dir}" && #{texcmd} && #{texcmd}`
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

    def remove_files
      pics = File::join(Rails.root,
                        'public',
                        thing_pictures_path(self))
      FileUtils::rm_rf pics
      if self.preview_file_name
        pdfs = File::dirname File::join(Rails.root,
                                        'public',
                                        self.preview_file_name)
        FileUtils::rm_rf pdfs
      end
    end
  end
end
