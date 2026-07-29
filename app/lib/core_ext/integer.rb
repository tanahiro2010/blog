# frozen_string_literal: true

class Integer
  def week
    self * 7.day
  end

  def month
    self.week * 4
  end

  def year
    self.month * 12
  end

  def quarter
    self.month * 3
  end

  def half_year
    self.month * 6
  end
end
