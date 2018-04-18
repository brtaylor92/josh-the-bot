module Manamoji

  #One way to do this, that I agree with, is to dynamically load what symbols
  #could be used for mana/symbol emoji. I've only included the 50 options I 
  #actually have, but could update it if necessary/I found the means to get
  #Discord Nitro and upload the emoji directly to the bot.
  COLORS = ["W", "U", "B", "R", "G"]
  NUMBERS = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20]
  ETC = ["C", "E", 'T', 'Q', 'S', "X"]

  #THIS STUFF ISN'T DONE YET, mostly cause it doesn't work

  #This code is lovingly ripped off from the original iteration of Scryfall's
  #discord bot. Theirs was in javascript, so I had to do a bit of translation,
  #but it follows the same basic principles as their Manamoji.
  def Manamoji.substitutions
    @substitutions = {}
    def Manamoji.build(before, after)
      @substitutions["#{before}"] = ":mana#{after.to_s.downcase}:"
    end
    

    ETC.each do |sym|
      Manamoji.build(sym, sym)
    end

    NUMBERS.each do |sym|
      Manamoji.build(sym, sym)
    end

    COLORS.each do |sym|
      Manamoji.build(sym, sym)
    end

    COLORS.each do |sym|
      Manamoji.build("2/#{sym}", "2#{sym}")
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

    return @substitutions
  end

  #THIS IS THE PART THAT DOESN'T WORK.
  def Manamoji.mana_parser(input_string)
    subs_hash = Manamoji.substitutions
    # puts subs_hash
    input_string.gsub!(/\{/, "")
    costs_array = input_string.split("}")
    puts costs_array
    # costs_array.each do |cost|
    #   cost.gsub!(/\{.+\}/, subs_hash)
    # end
    # puts costs_array
    # emoji_string = costs_array.join(" ")
    # return emoji_string

    # emoji_string = input_string.gsub(/\{(.)+\}/, 'R' => "manar")
    # puts input_string
    # return emoji_string
  end

end