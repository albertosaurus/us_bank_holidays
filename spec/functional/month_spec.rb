require 'spec_helper'

describe UsBankHolidays::Month do
  let(:january) { UsBankHolidays::Month.new(2014, 1) }

  it 'should record the correct month' do
    january.month.should == 1
  end

  it 'should record the correct year' do
    january.year.should == 2014
  end

  it 'should raise an error if the month is out of range' do
    [0,13].each { |m|
      expect {
        UsBankHolidays::Month.new(2014, m)
      }.to raise_error(ArgumentError)
    }
  end

  describe '.to_s' do

    let(:january_str) {
      <<-JAN
Su Mo Tu We Th Fr Sa
          1  2  3  4
 5  6  7  8  9 10 11
12 13 14 15 16 17 18
19 20 21 22 23 24 25
26 27 28 29 30 31
      JAN
    }

    it 'should convert the month to a string representation' do
      january.to_s.should == january_str
    end
  end

  context 'days of week' do
    {
      :sundays    => [5, 12, 19, 26],
      :mondays    => [6, 13, 20, 27],
      :tuesdays   => [7, 14, 21, 28],
      :wednesdays => [1, 8, 15, 22, 29],
      :thursdays  => [2, 9, 16, 23, 30],
      :fridays    => [3, 10, 17, 24, 31],
      :saturdays  => [4, 11, 18, 25]
    }.each do |method, days|

      describe ".#{method}" do
        it 'should gather up the required days and compact out the nils' do
          january.send(method).map{|dt| dt.day }.should == days
        end
      end

    end
  end
end