class ContentsController < ApplicationController
  include ContentHelper

  before_filter :get_parent
  # EDIT
  def show

  end

  # GET
  def download_pdf
    @template = DocumentTemplate.find params[:document_template][:id]
    res = @parent.regenerate_preview_file(@template)
    respond_to do |format|
      if res
        @result = res
        format.html { render "error_result" }
      else
        format.html { render "link_page" }
      end
    end
  end

  # POST
  def upload_picture
    pic = params[:picture]
    fname = File::join(Rails.root,
                       'public',
                       thing_pictures_path(@parent),
                       pic.original_filename)
    dir = File::dirname fname
    unless File::exists? dir
      FileUtils::mkdir_p dir
    end
    respond_to do |format|
      format.html do
        if File::exists? fname
          redirect_to content_of_path(@parent), :notice => "This file already exists"
        else
          File.open(fname, 'wb') do |file|
            file.write(pic.read)
          end
          redirect_to content_of_path(@parent), :notice => "File uploaded"
        end
      end
    end
  end

  # POST
  def delete_picture

  end


  protected

  def get_parent
    m = request.original_url.match(/\/([^\/]+)\/(\d*)\/content/)
    k = m[1]
    kid = m[2]
    parent_klasses = %w[offer_component commercial_offer]
    if klass = parent_klasses.detect { |pk| pk.pluralize == k }
      @parent = klass.camelize.constantize.find kid
      # @prent_path = (klass << "_path").constantize(@parent)

    end
  end
end
