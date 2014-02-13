module UsBankHolidays

  # Utility class to calculate where the federal holidays will actually fall
  # for any given year.
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

    # Initializes instance from a given year
    def initialize(year)
      @year = year

      init_fixed_holidays
      init_rolled_holidays

    end

    # Returns the federal holidays for the given year on the dates they will actually
    # be observed. In the event that New Year's Day for the following year falls on a
    # Saturday December 31 will also be included.
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

    {
      :january   => 1,
      :february  => 2,
      :march     => 3,
      :april     => 4,
      :may       => 5,
      :june      => 6,
      :july      => 7,
      :august    => 8,
      :september => 9,
      :october   => 10,
      :november  => 11,
      :december  => 12
    }.each do |month_name, month_index|
      # Create a method that returns an instance of UsBankHolidays::Month for
      # the needed month
      define_method(month_name) do
        ::UsBankHolidays::Month.new(year, month_index)
      end
    end

    private

      # These holidays are always fixed
      def init_fixed_holidays
        # Third Monday of January
        @mlk_day              = january.mondays[2]

        # Third Monday of February
        @washingtons_birthday = february.mondays[2]

        # Last Monday of May
        @memorial_day         = may.mondays.last

        # First Monday of September
        @labor_day            = september.mondays.first

        # Second Monday of October
        @columbus_day         = october.mondays[1]

        # Fourth Thursday of November
        @thanksgiving         = november.thursdays[3]
      end

      # These holidays are potentially rolled if they come on a weekend.
      def init_rolled_holidays
        # First of the year, rolls either forward or back.
        @new_years_day    = roll_nominal(Date.new(year, 1, 1))

        # 4'th of July
        @independence_day = roll_nominal(Date.new(year, 7, 4))

        # November 11
        @veterans_day     = roll_nominal(Date.new(year, 11, 11))

        # December 25
        @christmas        = roll_nominal(Date.new(year, 12, 25))
      end

      # Figures out where to roll the given nominal date. If it's a Saturday, assumes
      # it's the day before (Friday), if Sunday it's the date after (Monday), otherwise
      # just returns self.
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
