module ContentHelper

  def content_of_path(thing)
    url_for(thing) << '/content'
  end

  def download_pdf_of_path(thing)
    url_for(thing) << '/content/download_pdf'
  end

  def upload_picture_for_path(thing)
    url_for(thing) << '/content/upload_picture'
  end

  def thing_pictures_path(thing)
    File::join('pictures',
               thing.class.to_s.underscore.pluralize,
               thing.id.to_s)
  end

  def delete_picture_of_path(thing, *params)
    p = Hash[*params].to_query
    url_for(thing) << '/content/delete_picture' <<
      (params ? ('?' << p) : '')
  end

end
