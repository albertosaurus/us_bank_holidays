module UsBankHolidays

  # Utility class to make it easier to work with a particular month
  class Month

    attr_reader :year, :month

    def initialize(year, month)
      if month < 1 || month > 12
        raise ArgumentError, "Month is out of range, must be between 1 and 12, got #{month}"
      end
      @month = month
      @year = year
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

      define_method(day) do
        @weeks.map { |w|
          w[index]
        }.compact
      end

    end

    private

      def init_month
        @weeks = []
        current_date = Date.new(year, month, 1)
        week = init_first_week(current_date)
        while current_date.month == month
          week << current_date
          current_date += 1
          if week.size == 7 || current_date.month != month
            @weeks << week.freeze
            unless current_date.month > month
              week = []
            end
          end
        end
        @weeks.freeze
      end

      def init_first_week(start_date)
        case start_date.wday
        when 0
          []
        when 1
          [nil]
        when 2
          [nil, nil]
        when 3
          [nil, nil, nil]
        when 4
          [nil, nil, nil, nil]
        when 5
          [nil, nil, nil, nil, nil]
        when 6
          [nil, nil, nil, nil, nil, nil]
        end
      end

  end

end