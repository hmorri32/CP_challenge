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
  end

  describe "amount > 19 && amount < 100" do
    def test_under_one_hundred
      assert_equal "ninety eight and 0/100 dollar(s)", @c.amount_to_english(98)
      assert_equal "seventy four and 0/100 dollar(s)", @c.amount_to_english(74)
      assert_equal "twenty three and 0/100 dollar(s)", @c.amount_to_english(23)
    end

    def test_under_one_hundred_decimals
      assert_equal "twenty three and 10/100 dollar(s)", @c.amount_to_english(23.10)
      assert_equal "forty one and 99/100 dollar(s)", @c.amount_to_english(41.99)
      assert_equal "seventy seven and 98/100 dollar(s)", @c.amount_to_english(77.98)
      assert_equal "sixty one and 44/100 dollar(s)", @c.amount_to_english(61.44)
    end

    def test_under_one_hundred_decimal_overflow
      assert_equal "twenty three and 10/100 dollar(s)", @c.amount_to_english(23.1021321312)
      assert_equal "twenty three and 96/100 dollar(s)", @c.amount_to_english(23.955555555)
    end
  end
end
