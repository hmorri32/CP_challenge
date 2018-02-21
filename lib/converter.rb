# Convert 2523.04
# Two thousand five hundred twenty-three and 04/100 dollars
class Converter
  def nineteen
    %w(one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
  end

  def tens_block
    %w(twenty thirty forty fifty sixty seventy eighty ninety)
  end

  def amount_to_english(n)
    return "#{nineteen[n - 1]} and #{cent_handler(n)} dollar(s)" if n < 20
    return tens_block[(n / 10) - 2] + (n % 10 == 0 ? '' : " #{amount_to_english(n % 10)}") if n < 99
  end

  def cents?(n)
    n.to_s.include?('.')
  end

  def cent_handler(n)
    return "0/100" unless n.to_s.include?('.')
    cents = n.to_s.split(".")[-1]
    if cents.length > 2
      cents = cents[0..2]
      return "#{cents[0..1]}/100" if cents[0] == '0'
      cents = cents.to_i.round(-1).to_s[0..1]
    end
    "#{cents}/100"
  end
end

if $PROGRAM_NAME == __FILE__
  c = Converter.new
  require 'pry'; binding.pry
  stuff = 'cool'
end
