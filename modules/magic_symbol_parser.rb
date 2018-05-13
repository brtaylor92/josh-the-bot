module Manamoji
  # One way to do this, that I agree with, is to dynamically load what symbols
  # could be used for mana/symbol emoji. I've only included the 50 options I 
  # actually have, but could update it if necessary/I found the means to get
  # Discord Nitro and upload the emoji directly to the bot.
  

  # This code is lovingly ripped off from the original iteration of Scryfall's
  # discord bot. Theirs was in javascript, so I had to do a bit of translation,
  # but it follows the same basic principles as their Manamoji.
  COLORS = ["W", "U", "B", "R", "G"]
  NUMBERS = [0..16, 20]
  ETC = ["C", "E", 'T', 'Q', 'S', "X"]

  @@substitutions = {}

  def Manamoji.build(before, after = nil)
    @@substitutions["#{before}"] = "mana#{(after.nil? ? before : after).to_s.downcase}"
  end
  

  ETC.each do |sym|
    Manamoji.build(sym)
  end

  NUMBERS.each do |sym|
    Manamoji.build(sym)
  end

  COLORS.each do |sym|
    Manamoji.build(sym)
  end

  COLORS.each do |sym|
    Manamoji.build("2/#{sym}")
  end

  COLORS.each do |sym|
    Manamoji.build("#{sym}/P", "#{sym}p")
  end

  COLORS.each do |sym_1|
    COLORS.each do |sym_2|
      if sym_1 != sym_2
        Manamoji.build("#{sym_1}/#{sym_2}", "#{sym_1}#{sym_2}")
      end
    end
  end

  def Manamoji.get_emoji(input_string)
    input_string.gsub!(/\{/, "")
    costs_array = input_string.split("}")
    costs_array.map { |cost| @@substitutions[cost]}
  end
end