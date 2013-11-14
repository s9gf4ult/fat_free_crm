class ContentsController < ApplicationController
  before_filter :get_parent
  # EDIT
  def show
    
  end


  protected

  def get_parent
    m = request.original_url.match(/\/([^\/]+)\/(\d*)\/content/)
    k = m[1]
    kid = m[2]
    parent_klasses = %w[offer_component commercial_offer]
    if klass = parent_klasses.detect { |pk| pk.pluralize == k }
      @parent = klass.camelize.constantize.find kid
    end
  end
end
