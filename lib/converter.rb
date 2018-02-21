# Convert 2523.04
# Two thousand five hundred twenty-three and 04/100 dollars
class Converter
  def amount_to_english(n)
    case
    when n < 20
      "#{to_twenty[n - 1]} #{cent_handler(n)}"
    when n < 100
      tens_block[(n / 10) - 2] + (n % 10 == 0 ? " #{cent_handler}" : " #{amount_to_english(n % 10)}")
    when n < 1000
      "#{to_twenty[(n / 100) - 1]} hundred" + (n % 100 == 0 ? " #{cent_handler}" : " #{amount_to_english(n % 100)}")
    end
  end

  private
    def cent_handler(n = 0)
      cents = n.to_s.split(".")[-1]
      if cents.length > 2
        cents = cents[0..2]
        return "and #{cents[0..1]}/100 dollar(s)" if cents[0] == '0'
        cents = cents.to_i.round(-1).to_s[0..1]
      end
      cents = 0 unless cents?(n)
      "and #{cents}/100 dollar(s)"
    end

    def cents?(n)
      n.to_s.include?('.')
    end

    def to_twenty
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