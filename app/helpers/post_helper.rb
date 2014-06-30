module PostHelper

  def emitPost post
    html =<<END
<div class="post">
<h1>#{post.headline}</h1>
<div class="published_at">#{post.published_at}</div>
<div class="created_at">#{post.created_at}</div>
<div class="updated_at">#{post.updated_at}</div>
<div>#{post.content_as_html}</div>
<div class="permalink"><a href="#{post_path(post)}">Permalink</a></div>
</div><!--post-->
END
    html.html_safe
  end

end
