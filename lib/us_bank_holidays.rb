require 'date'

require 'us_bank_holidays/version'
require 'us_bank_holidays/holiday_year'
require 'us_bank_holidays/month'

module UsBankHolidays

  def self.weekend?(date)
    date.sunday? || date.saturday?
  end

  def self.bank_holiday?(date)
    weekend?(date) ||
      ::UsBankHolidays::HolidayYear.new(date.year).bank_holidays.include?(date)
  end

  def self.next_banking_day(date)
    if (next_date = date + 1).bank_holiday?
      next_banking_day(next_date)
    else
      next_date
    end
  end

  def self.previous_banking_day(date)
    if (previous_date = date - 1).bank_holiday?
      previous_banking_day(previous_date)
    else
      previous_date
    end
  end

  module DateMethods

    def weekend?
      ::UsBankHolidays.weekend? self
    end

    def bank_holiday?
      ::UsBankHolidays.bank_holiday? self
    end

    def next_banking_day
      ::UsBankHolidays.next_banking_day self
    end

    def previous_banking_day
      ::UsBankHolidays.previous_banking_day self
    end

    def add_banking_days(days)
      day = self
      if days > 0
        days.times { day = day.next_banking_day }
      elsif days < 0
        (-days).times { day = day.previous_banking_day }
      end
      day
    end
  end

end

::Date.class_eval do
  include ::UsBankHolidays::DateMethods
end
