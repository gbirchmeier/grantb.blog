module DateHelper
  def pretty_short_date(d)
    return "" if d.nil?
    d.strftime("%b %e, %Y")
  end

  def numeric_short_date(d)
    return "" if d.nil?
    d.strftime("%Y-%m-%d")
  end
end

