module DateHelper
  def pretty_short_date(d)
    return "" unless d
    d.strftime("%b %e, %Y")
  end

  def numeric_date(d)
    return "" unless d
    d.strftime("%Y-%m-%d")
  end

  def numeric_date_and_time(d)
    return "" unless d
    d.strftime("%Y-%m-%d %l:%M%P")
  end
end

