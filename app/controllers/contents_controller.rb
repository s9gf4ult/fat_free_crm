class ContentsController < ApplicationController
  before_filter :get_parent
  # EDIT
  def show
    
  end

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
