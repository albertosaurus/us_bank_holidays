require 'spec_helper'

describe UsBankHolidays do
  let(:sample_holidays) {
    [
      '2014-01-01', #New Year’s Day
      '2014-01-20', #Birthday of Martin Luther King, Jr.
      '2014-02-17', #Washington’s Birthday
      '2014-05-26', #Memorial Day
      '2014-07-04', #Independence Day
      '2014-09-01', #Labor Day
      '2014-10-13', #Columbus Day
      '2014-11-11', #Veterans Day
      '2014-11-27', #Thanksgiving Day
      '2014-12-25', #Christmas Day

      '2015-01-01', #New Year’s Day
      '2015-01-19', #Birthday of Martin Luther King, Jr.
      '2015-02-16', #Washington’s Birthday
      '2015-05-25', #Memorial Day
      '2015-07-03', #Independence Day
      '2015-09-07', #Labor Day
      '2015-10-12', #Columbus Day
      '2015-11-11', #Veterans Day
      '2015-11-26', #Thanksgiving Day
      '2015-12-25', #Christmas Day

      '2016-01-01', #New Year’s Day
      '2016-01-18', #Birthday of Martin Luther King, Jr.
      '2016-02-15', #Washington’s Birthday
      '2016-05-30', #Memorial Day
      '2016-07-04', #Independence Day
      '2016-09-05', #Labor Day
      '2016-10-10', #Columbus Day
      '2016-11-11', #Veterans Day
      '2016-11-24', #Thanksgiving Day
      '2016-12-26', #Christmas Day

      '2017-01-02', #New Year’s Day
      '2017-01-16', #Birthday of Martin Luther King, Jr.
      '2017-02-20', #Washington’s Birthday
      '2017-05-29', #Memorial Day
      '2017-07-04', #Independence Day
      '2017-09-04', #Labor Day
      '2017-10-09', #Columbus Day
      '2017-11-10', #Veterans Day
      '2017-11-23', #Thanksgiving Day
      '2017-12-25', #Christmas Day

      '2018-01-01', #New Year’s Day
      '2018-01-15', #Birthday of Martin Luther King, Jr.
      '2018-02-19', #Washington’s Birthday
      '2018-05-28', #Memorial Day
      '2018-07-04', #Independence Day
      '2018-09-03', #Labor Day
      '2018-10-08', #Columbus Day
      '2018-11-12', #Veterans Day
      '2018-11-22', #Thanksgiving Day
      '2018-12-25', #Christmas Day

      '2019-01-01', #New Year’s Day
      '2019-01-21', #Birthday of Martin Luther King, Jr.
      '2019-02-18', #Washington’s Birthday
      '2019-05-27', #Memorial Day
      '2019-07-04', #Independence Day
      '2019-09-02', #Labor Day
      '2019-10-14', #Columbus Day
      '2019-11-11', #Veterans Day
      '2019-11-28', #Thanksgiving Day
      '2019-12-25', #Christmas Day

      '2020-01-01', #New Year’s Day
      '2020-01-20', #Birthday of Martin Luther King, Jr.
      '2020-02-17', #Washington’s Birthday
      '2020-05-25', #Memorial Day
      '2020-07-03', #Independence Day
      '2020-09-07', #Labor Day
      '2020-10-12', #Columbus Day
      '2020-11-11', #Veterans Day
      '2020-11-26', #Thanksgiving Day
      '2020-12-25'  #Christmas Day
    ].map {|date_str| Date.parse(date_str) }
  }

  let(:sample_weekends) { [Date.new(2014, 2, 1), Date.new(2014, 2, 2)] }

  let(:sample_weekdays) { [3,  4,  5,  6,  7].map{|d| Date.new(2014, 2, d) } }

  describe '.bank_holiday?' do
    it 'should determine bank holidays on the list' do
      sample_holidays.each{ |holiday| UsBankHolidays.bank_holiday?(holiday).should be_true }
    end

    it 'weekends should be bank holidays' do
      sample_weekends.each{ |weekend| UsBankHolidays.bank_holiday?(weekend).should be_true }
    end

    it 'regular days should not be bank holidays' do
      sample_weekdays.each { |day| UsBankHolidays.bank_holiday?(day).should be_false }
    end
  end

  describe '.weekend?' do
    it 'should recognize weekends' do
      sample_weekends.each{ |weekend| UsBankHolidays.weekend?(weekend).should be_true }
    end

    it 'weekdays should not be considered weekends' do
      sample_weekdays.each { |day| UsBankHolidays.weekend?(day).should be_false }
    end
  end

  describe ::UsBankHolidays::DateMethods do

    describe '.bank_holiday?' do

      it 'should recognize bank holidays' do
        sample_holidays.each{ |holiday| holiday.bank_holiday?.should be_true }
      end

      it 'should treat weekends as bank holidays' do
        sample_weekends.each{ |weekend| weekend.bank_holiday?.should be_true }
      end

      it 'should not treat regular weekdays as bank holidays' do
        sample_weekdays.each { |day| day.bank_holiday?.should be_false }
      end
    end

    describe '.weekend?' do

      it 'should recognize weekends' do
        sample_weekends.each{ |weekend| weekend.weekend?.should be_true }
      end

      it 'weekdays should not be considered weekends' do
        sample_weekdays.each { |day| day.weekend?.should be_false }
      end

    end

    describe '.next_banking_day' do
      it 'should determine the next banking day' do
        Date.new(2014, 1, 1).next_banking_day.should == Date.new(2014, 1, 2)
        Date.new(2014, 1, 2).next_banking_day.should == Date.new(2014, 1, 3)
        Date.new(2014, 1, 3).next_banking_day.should == Date.new(2014, 1, 6)
        Date.new(2014, 1, 4).next_banking_day.should == Date.new(2014, 1, 6)
        Date.new(2014, 1, 5).next_banking_day.should == Date.new(2014, 1, 6)
      end
    end

    describe '.previous_baking_day' do
      it 'should determine the previous banking day' do
        Date.new(2014, 1, 7).previous_banking_day.should == Date.new(2014, 1, 6)
        Date.new(2014, 1, 6).previous_banking_day.should == Date.new(2014, 1, 3)
        Date.new(2014, 1, 5).previous_banking_day.should == Date.new(2014, 1, 3)
        Date.new(2014, 1, 4).previous_banking_day.should == Date.new(2014, 1, 3)
        Date.new(2014, 1, 21).previous_banking_day.should == Date.new(2014, 1, 17)
      end
    end

    describe '.add_banking_days' do
      it 'should return self if given 0' do
        Date.new(2014, 1, 7).add_banking_days(0).should == Date.new(2014, 1, 7)
      end

      it 'should return self if given 0 even if self is a bank holiday' do
        Date.new(2014, 1, 4).add_banking_days(0).should == Date.new(2014, 1, 4)
      end

      it 'if given a positive number, should add banking days, ignoring bank holidays' do
        Date.new(2014, 1, 16).add_banking_days(2).should == Date.new(2014, 1, 21)
      end

      it 'if given a negative number, should subtract banking days, ignoring bank holidays' do
        Date.new(2014, 1, 21).add_banking_days(-2).should == Date.new(2014, 1, 16)
      end
    end
  end
end
