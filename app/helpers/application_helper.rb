module ApplicationHelper
  def markdown( content )
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true, fenced_code_blocks: true)
    @markdown.render( content || '' ).html_safe
  end

  def external_link( url )
    /^(http(?:s?))/.match( url ) ? url : "http://#{url}"
  end
end
