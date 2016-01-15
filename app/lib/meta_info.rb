class MetaInfo

  SITE_NAME = "GrantB.net"
  TWITTER_SITE = "@GrantBirchmeier"
  

  def initialize(user,title,url,description)
    @user = user
    @title = title
    @url = url
    @description = description
  end

  def to_h
    p = {}
    p["og:type"] = "article"
    p["og:title"] = @title
    p["og:url"] = @url
    p["og:site_name"] = SITE_NAME
    p["og:description"] = @description if @description

# Twitter has two summary card types.
# They are the same except for twitter:image (which is optional in both cases).
# * summary: min size 120x120 image, less than 1MB, will be cropped to square
# * summary_large_image: min size 150 tall x 280 wide, less than 1MB

    n = {}
    n["author"] = @user.full_name
    n["twitter:card"] = "summary"
    n["twitter:site"] = TWITTER_SITE
    n["twitter:title"] = @title
    n["twitter:description"] = @description || "placeholder"

    { properties: p, names: n }
  end

end
