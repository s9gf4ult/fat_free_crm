module ContentHelper

  def content_of_path(thing)
    thing_path(thing) << '/content'
  end

  def download_pdf_of_path(thing)
    thing_path(thing) << '/content/download_pdf'
  end

end
