module ApplicationHelper

  def emit_form_errors(obj)
    return "" unless obj.errors.any?
    rv <<-EOS
<div id="form_errors">
	<h2>#{pluralize(obj.errors.count,"error")} prohibited this object from being saved:</h2>
	<ul>
#{obj.errors.full_messages.collect {|msg| rv << "<li>#{msg}</li>"}.join("\n") + "\n"}
	</ul>
</div>
EOS
    rv.html_safe
  end

  def pretty_short_date(d)
    return "" if nil
    d.strftime("%b %d, %Y")
  end

end
