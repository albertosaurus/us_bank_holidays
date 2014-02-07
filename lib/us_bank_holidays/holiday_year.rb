module UsBankHolidays

  class HolidayYear

    attr_reader :year,
                :new_years_day,
                :mlk_day,
                :washingtons_birthday,
                :memorial_day,
                :independence_day,
                :labor_day,
                :columbus_day,
                :veterans_day,
                :thanksgiving,
                :christmas

    def initialize(year)
      @year                 = year

      # First of the year, rolls either forward or back.
      @new_years_day        = roll_nominal(Date.new(year, 1, 1))

      # Third Monday of January
      @mlk_day              = ::UsBankHolidays::Month.new(year, 1).mondays[2]

      # Third Monday of February
      @washingtons_birthday = ::UsBankHolidays::Month.new(year, 2).mondays[2]

      # Last Monday of May
      @memorial_day         = ::UsBankHolidays::Month.new(year, 5).mondays.last

      # 4'th of July
      @independence_day     = roll_nominal(Date.new(year, 7, 4))

      # First Monday of September
      @labor_day            = ::UsBankHolidays::Month.new(year, 9).mondays.first

      # Second Monday of October
      @columbus_day         = ::UsBankHolidays::Month.new(year, 10).mondays[1]

      # November 11
      @veterans_day         = roll_nominal(Date.new(year, 11, 11))

      # Fourth Thursday of November
      @thanksgiving         = ::UsBankHolidays::Month.new(year, 11).thursdays[3]

      # December 25
      @christmas            = roll_nominal(Date.new(year, 12, 25))

    end

    def bank_holidays
      @bank_holidays ||= begin
        holidays = [ new_years_day,
          mlk_day,
          washingtons_birthday,
          memorial_day,
          independence_day,
          labor_day,
          columbus_day,
          veterans_day,
          thanksgiving,
          christmas
        ]
        if Date.new(year + 1, 1, 1).saturday?
          holidays << Date.new(year, 12, 31)
        end
        holidays.freeze
      end
    end

    private

      def roll_nominal(nominal)
        if nominal.saturday?
          nominal - 1
        elsif nominal.sunday?
          nominal + 1
        else
          nominal
        end
      end

  end

end