# Convert 2523.04
# Two thousand five hundred twenty-three and 04/100 dollars
class Converter
  def amount_to_english(n)
    "#{build_numbers(n)} #{cent_handler(n)}"
  end

  def build_numbers(n)
    n = n.to_s.split('.')[0].to_i
    case
    when n < 20
      ints_to_twenty[n-1]
    when n < 100
      tens_block[(n / 10) - 2] + (n % 10 == 0 ? "" : " #{build_numbers(n % 10)}")
    when n < 1e3
      "#{build_numbers(n / 100)} hundred" + (n % 100 == 0 ? "" : " #{build_numbers(n % 100)}")
    when n < 1e6
      "#{build_numbers(n / 1000)} thousand" + (n % 1000 == 0 ? "" : " #{build_numbers(n % 1000)}")
    end
  end

  # def recursive_render(number_array, place, name, n)
  #   "#{number_array[(n / place) - 1]} #{name}" + (n % place == 0 ? "" : " #{amount_to_english(n % place)}" )
  # end

  private
    def cent_handler(n = 0)
      cents = n.to_s.split(".")[-1]
      if cents.length > 2
        cents = cents[0..2]
        return "and #{cents[0..1]}/100 dollar(s)" if cents[0] == '0'
        cents = cents.to_i.round(-1).to_s[0..1]
      end
      cents = "#{cents}0" if cents.to_s.length == 1
      cents = 0 if !cents?(n)
      "and #{cents}/100 dollar(s)"
    end

    def cents?(n)
      n.to_s.include?('.')
    end

    def ints_to_twenty
      %w(one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
    end

    def tens_block
      %w(twenty thirty forty fifty sixty seventy eighty ninety)
    end
end

if $PROGRAM_NAME == __FILE__
  c = Converter.new
  require 'pry'; binding.pry
  stuff = 'cool'
end