module ApplicationHelper

  def emit_form_errors(obj)
    return "" unless obj.errors.any?
    rv = <<-EOS
<div id="form-errors">
	<h2>#{pluralize(obj.errors.count,"error")} prohibited this object from being saved:</h2>
	<ul>
#{obj.errors.full_messages.collect {|msg| "<li>#{msg}</li>"}.join("\n")}
	</ul>
</div>
EOS
    rv.html_safe
  end

  def nnne(s)
    # Returns non-nil non-empty string.  Empty string is converted to "&nbsp;".
    # It is expected that callers will use .html_safe on the result.
    return "&nbsp;" if s.nil? or s.strip.empty?
    s
  end

end
