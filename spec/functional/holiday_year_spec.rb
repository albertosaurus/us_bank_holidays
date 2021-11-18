require 'spec_helper'

RSpec.describe UsBankHolidays::HolidayYear do

  context "should determine bank holidays" do

    context "Before 2021" do

      context "Force Saturday date rolling" do
        before :each do
          allow(::UsBankHolidays).to receive(:saturday_holiday_date_rolling?).and_return(true)
        end

        it 'should determine bank holidays' do
          expect(UsBankHolidays::HolidayYear.new(2017).bank_holidays).to eq([
                                                                              '2017-01-02', #New Year’s Day
                                                                              '2017-01-16', #Birthday of Martin Luther King, Jr.
                                                                              '2017-02-20', #Washington’s Birthday
                                                                              '2017-05-29', #Memorial Day
                                                                              '2017-07-04', #Independence Day
                                                                              '2017-09-04', #Labor Day
                                                                              '2017-10-09', #Columbus Day
                                                                              '2017-11-10', #Veterans Day
                                                                              '2017-11-23', #Thanksgiving Day
                                                                              '2017-12-25' #Christmas Day
                                                                            ].map { |d| Date.parse(d) }
                                                                         )
        end

      end

      context "No Saturday date rolling" do
        it 'should determine bank holidays' do
          expect(UsBankHolidays::HolidayYear.new(2017).bank_holidays).to eq([
                                                                              '2017-01-02', #New Year’s Day
                                                                              '2017-01-16', #Birthday of Martin Luther King, Jr.
                                                                              '2017-02-20', #Washington’s Birthday
                                                                              '2017-05-29', #Memorial Day
                                                                              '2017-07-04', #Independence Day
                                                                              '2017-09-04', #Labor Day
                                                                              '2017-10-09', #Columbus Day
                                                                              '2017-11-11', #Veterans Day
                                                                              '2017-11-23', #Thanksgiving Day
                                                                              '2017-12-25' #Christmas Day
                                                                            ].map { |d| Date.parse(d) }
                                                                         )
        end

      end

    end

    context "2021 and later" do

      context "Force Saturday date rolling" do

        before :each do
          allow(::UsBankHolidays).to receive(:saturday_holiday_date_rolling?).and_return(true)
        end

        it 'should determine bank holidays' do
          expect(UsBankHolidays::HolidayYear.new(2021).bank_holidays).to eq([
                                                                              '2021-01-01', #New Year’s Day
                                                                              '2021-01-18', #Birthday of Martin Luther King, Jr.
                                                                              '2021-02-15', #Washington’s Birthday
                                                                              '2021-05-31', #Memorial Day
                                                                              '2021-06-18', #Juneteenth
                                                                              '2021-07-05', #Independence Day
                                                                              '2021-09-06', #Labor Day
                                                                              '2021-10-11', #Columbus Day
                                                                              '2021-11-11', #Veterans Day
                                                                              '2021-11-25', #Thanksgiving Day
                                                                              '2021-12-24', #Christmas Day
                                                                              '2021-12-31'  #New Year’s Day
                                                                            ].map { |d| Date.parse(d) }
                                                                         )
        end

      end

      context "No Saturday date rolling" do
        before :each do
          allow(::UsBankHolidays).to receive(:saturday_holiday_date_rolling?).and_return(false)
        end

        it 'should determine bank holidays' do
          expect(UsBankHolidays::HolidayYear.new(2021).bank_holidays).to eq([
                                                                              '2021-01-01', #New Year’s Day
                                                                              '2021-01-18', #Birthday of Martin Luther King, Jr.
                                                                              '2021-02-15', #Washington’s Birthday
                                                                              '2021-05-31', #Memorial Day
                                                                              '2021-06-19', #Juneteenth
                                                                              '2021-07-05', #Independence Day
                                                                              '2021-09-06', #Labor Day
                                                                              '2021-10-11', #Columbus Day
                                                                              '2021-11-11', #Veterans Day
                                                                              '2021-11-25', #Thanksgiving Day
                                                                              '2021-12-25' #Christmas Day
                                                                            ].map { |d| Date.parse(d) }
                                                                         )
        end

      end

    end

  end

  context 'Months' do
    let(:year) { UsBankHolidays::HolidayYear.new(2014) }

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
      it "should respond to '#{month_name}' and return the right month" do
        expect(year.respond_to?(month_name)).to eq(true)
        month = year.send(month_name)
        month.year.should  == 2014
        month.month.should == month_index
      end
    end
  end
end
