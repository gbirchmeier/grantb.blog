module PostHelper

  def emitPost post
    html =<<END
<div class="post">
<div><strong>#{post.headline}</strong></div>

<div>by #{post.user.username}</div>

<div>
Published #{post.published_at}<br/>
Updated #{post.updated_at}<br/>
Created #{post.created_at}<br/>
</div>

<div>#{post.content_as_html}</div>
</div><!--post-->
END
    html.html_safe
  end

end
