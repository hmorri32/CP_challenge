require 'minitest/autorun'
require './lib/Converter'

describe Converter do
  before { @c = Converter.new }

  def test_converter_exists
    assert @c
    assert_instance_of Converter, @c
  end

  describe "amount < 20" do
    def test_dollar_to_words_under_twenty
      assert_equal "one and 0/100 dollar(s)", @c.amount_to_english(1)
      assert_equal "two and 0/100 dollar(s)", @c.amount_to_english(2)
      assert_equal "three and 0/100 dollar(s)", @c.amount_to_english(3)
      assert_equal "fifteen and 0/100 dollar(s)", @c.amount_to_english(15)
      assert_equal "nineteen and 0/100 dollar(s)", @c.amount_to_english(19)
    end

    def test_under_twenty_with_decimals
      assert_equal "one and 05/100 dollar(s)", @c.amount_to_english(1.05)
      assert_equal "two and 35/100 dollar(s)", @c.amount_to_english(2.35)
      assert_equal "twenty two and 35/100 dollar(s)", @c.amount_to_english(22.35)
      assert_equal "forty seven and 14/100 dollar(s)", @c.amount_to_english(47.14)
    end

    def test_under_twenty_with_decimal_overflow
      assert_equal "one and 05/100 dollar(s)", @c.amount_to_english(1.0532432432)
    end

    def test_negative_value
      assert_equal "negative four and 0/100 dollar(s)", @c.amount_to_english(-4)
    end
  end

  describe "amount > 19 && amount < 100" do
    def test_under_one_hundred
      assert_equal "ninety eight and 0/100 dollar(s)", @c.amount_to_english(98)
      assert_equal "seventy four and 0/100 dollar(s)", @c.amount_to_english(74)
      assert_equal "twenty three and 0/100 dollar(s)", @c.amount_to_english(23)
      assert_equal "fifty and 0/100 dollar(s)", @c.amount_to_english(50)
      assert_equal "ninety nine and 0/100 dollar(s)", @c.amount_to_english(99)
      assert_equal "twenty and 0/100 dollar(s)", @c.amount_to_english(20)
    end

    def test_under_one_hundred_decimals
      assert_equal "twenty three and 10/100 dollar(s)", @c.amount_to_english(23.10000)
      assert_equal "twenty three and 20/100 dollar(s)", @c.amount_to_english(23.20)
      assert_equal "forty one and 99/100 dollar(s)", @c.amount_to_english(41.99)
      assert_equal "seventy seven and 98/100 dollar(s)", @c.amount_to_english(77.98)
      assert_equal "sixty one and 44/100 dollar(s)", @c.amount_to_english(61.44)
    end

    def test_under_one_hundred_decimal_overflow
      assert_equal "twenty three and 10/100 dollar(s)", @c.amount_to_english(23.1021321312)
      assert_equal "twenty three and 96/100 dollar(s)", @c.amount_to_english(23.955555555)
    end
  end

  describe "amount > 99 && amount < 1000" do
    def test_amount_under_nine_nine_nine
      assert_equal "three hundred fifteen and 0/100 dollar(s)", @c.amount_to_english(315)
      assert_equal "three hundred and 0/100 dollar(s)", @c.amount_to_english(300)
    end
  end

  describe "amount > 9999 && amount < 100_000" do
    def test_amount_under_nine_nine_nine_nine
      assert_equal "three thousand three hundred fifteen and 0/100 dollar(s)", @c.amount_to_english(3315)
      assert_equal "forty thousand three hundred fifteen and 0/100 dollar(s)", @c.amount_to_english(40315)
      assert_equal "forty thousand three hundred sixteen and 67/100 dollar(s)", @c.amount_to_english(40316.67)
    end
  end

  describe "amount < 1_000_000" do
    def test_amount_under_mil
      assert_equal "three million and 0/100 dollar(s)", @c.amount_to_english(3_000_000)
    end
  end
end
