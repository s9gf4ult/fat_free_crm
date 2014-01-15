module ContentStuff
  require 'iconv'

  extend ActiveSupport::Concern

  included do
    include ContentHelper
    before_save :remove_crlf_content, :merge_definitions
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

      res = run_latex texfn, template.program_name
      res
    end

    def my_pictures
      mydir = File::join(Rails.root,
                         'public',
                         thing_pictures_path(self))
      if File::exists? mydir
        (Dir::entries mydir).find_all do |fn|
          not File::directory?(File::join(mydir, fn))
        end.map do |fn|
          File::join(thing_pictures_path(self), fn)
        end
      else
        []
      end
    end

    def parsed_definitions
      ret = {}
      if self.definitions
        self.definitions.split(/\n/).each do |line|
          m = /^\ *(#[a-zA-Z-]{1,20}#)(.*)$/.match line
          if m
            ret[m[1]] = m[2].strip
          end
        end
      end
      ret
    end

    def parsed_definitions=(defs)
      keys = defs.keys.sort
      self.definitions = keys.map do |key|
        "#{key} #{defs[key]}"
      end.join "\n"
    end

    def content_definitions
      self.content.scan(/\\#[a-zA-Z-]{1,20}\\#/).map do |key|
        key.gsub '\#', '#'
      end
    end

    def content_with_definitions
      if self.definitions
        ret = self.content
        self.parsed_definitions.each do |k, v|
          subk = k.gsub '#', '\#'
          if v && v.length > 0
            ret = ret.gsub subk, v
          elsif self.respond_to?(:offer_components)
            pws = Setting['magic_definitions']
            if pws.has_key? k
              c = self.offer_components.where(:component_type => pws[k]).first
              if c
                ret = ret.gsub subk, c.name
              end
            end
          end
        end
        ret
      else
        self.content
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
        post << "\n" << template.content_after
      end

      pubpath = File::join(Rails.root, 'public', '/')

      File.open texfile, 'w' do |f|
        f << pre
        f << "\n\\setupexternalfigures[directory=#{pubpath}]\n"
        f << self.content_with_definitions
        f << post
      end
    end

    def run_latex(texfile, program_name)
      timeout = 40              # 60 secs to wait for processing
      dir = File::dirname texfile
      name = File::basename texfile
      if program_name == "context"
        texcmd = "#{program_name} --batchmode --noconsole '#{name}'"
      else
        raise Exception.new "uknown program to call"
      end

      p = Process::spawn("cd '#{dir}' && #{texcmd}")
      res = nil
      begin
        Timeout::timeout(timeout) do
          (n, res) = Process::wait2(p) # wait for pid
        end
      rescue Timeout::Error
        Process.kill('TERM', p)
      end

      if res && res.success?
        false
      else
        ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
        open(File::join(dir, (File::basename(name, 'tex') << 'log') )) do |f|
          ic.iconv f.read
        end
      end
    end

    def remove_crlf_content
      if self.content
        self.content = self.content.gsub /\r\n?/, "\n"
      end
    end

    def merge_definitions
      if self.content
        defs = self.parsed_definitions
        contkeys = self.content_definitions
        contkeys.each do |key|
          defs[key] ||= ''
        end
        self.parsed_definitions = defs
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
