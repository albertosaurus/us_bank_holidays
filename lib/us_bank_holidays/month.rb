module UsBankHolidays

  # Utility class to make it easier to work with a particular month. It represents
  # a month of a specific year.
  class Month

    attr_reader :year, :month

    # Initializes an instance from a year and a month. Raises an error if the
    # month is not in the allowed range, i.e. it must be between 1 and 12 inclusive.
    def initialize(year, month)
      if month < 1 || month > 12
        raise ArgumentError, "Month is out of range, must be between 1 and 12, got #{month}"
      end
      @month = month
      @year  = year
      @weeks = []
      init_month
    end

    def to_s
      @to_s ||= begin
        wks = @weeks.map { |w|
          w.map { |d|
            if d.nil?
              '  '
            elsif d.day < 10
              " #{d.day}"
            else
              "#{d.day}"
            end
          }.join(' ')
        }.join("\n")
        "Su Mo Tu We Th Fr Sa\n#{wks}\n"
      end
    end

    {
      :sundays    => 0,
      :mondays    => 1,
      :tuesdays   => 2,
      :wednesdays => 3,
      :thursdays  => 4,
      :fridays    => 5,
      :saturdays  => 6
    }.each do |day, index|

      # For each day of the week, define a method that will return the set of
      # all the matching dates in the month. For example, this lets me determine
      # all the Mondays of the month, or all the Fridays.
      define_method(day) do
        @weeks.map { |w|
          w[index]
        }.compact
      end

    end

    # Returns true if the given month contains the given date, false otherwise.
    def contains?(date)
      year == date.year && month == date.month
    end

    private

      def init_month
        current_date = Date.new(year, month, 1)
        week = init_first_week(current_date)
        while current_date.month == month
          week << current_date
          current_date += 1
          if week.size == 7 || current_date.month != month
            @weeks << week.freeze
            week = [] if contains?(current_date)
          end
        end
        @weeks.freeze
      end

      def init_first_week(start_date)
        offset = []
        start_date.wday.times { offset << nil }
        offset
      end

  end

end