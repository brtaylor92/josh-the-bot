require 'discordrb'
require 'yaml'
require_relative './modules/magic_symbol_parser'

CONFIG = YAML.load_file('config.yaml')

class JoshTheBot

  include Manamoji

  bot = Discordrb::Commands::CommandBot.new token: CONFIG["DISCORD_TOKEN"], prefix: '!'

  bot.message(with_text: 'Ping!') do |event|
    m = event.respond('Pong!')
    m.edit "Pong! Time taken: #{Time.now - event.timestamp} seconds."
  end

  bot.message(with_text: 'NOICE') do |event|
    event.respond 'ALSO NOICE'
  end

  bot.message(contains: /\[\[.+\]\]/) do |event|
    card = event.content.match /\[\[.+\]\]/
    card_name = card.to_s.split("[[")[1].split("]]")[0]

    if card_name =~ /^[$]/ #Get card price
      card_name = card_name.split("$")[1]
      url = "https://api.scryfall.com/cards/named?exact=#{card_name}"
      response = RestClient.get(url)

      body = JSON.parse(response)
      event.channel.send_embed do |embed|
        embed.title = body["name"] + " " + body["mana_cost"]
        embed.url = body["scryfall_uri"]
        embed.description = "$" + body["usd"]
        embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: body["image_uris"]["normal"])
        if body["colors"][1]
          embed.color = 14799002
        elsif body["colors"][0] == "W"
          embed.color = 16579807
        elsif body["colors"][0] == "U"
          embed.color = 9622767
        elsif body["colors"][0] == "B"
          embed.color = 13484735
        elsif body["colors"][0] == "R"
          embed.color = 16754056
        elsif body["colors"][0] == "G"
          embed.color = 8772015
        else
          embed.color = 13550272
        end
      end

    elsif card_name =~ /^[!]/ #Get card image
      card_name = card_name.split("!")[1]
      url = "https://api.scryfall.com/cards/named?exact=#{card_name}"
      response = RestClient.get(url)

      body = JSON.parse(response)

      event.channel.send_embed do |embed|
        embed.title = body["name"] + " " + body["mana_cost"]
        embed.url = body["scryfall_uri"]
        embed.image = Discordrb::Webhooks::EmbedImage.new(url: body["image_uris"]["normal"])
        if body["colors"][1]
          embed.color = 14799002
        elsif body["colors"][0] == "W"
          embed.color = 16579807
        elsif body["colors"][0] == "U"
          embed.color = 9622767
        elsif body["colors"][0] == "B"
          embed.color = 13484735
        elsif body["colors"][0] == "R"
          embed.color = 16754056
        elsif body["colors"][0] == "G"
          embed.color = 8772015
        else
          embed.color = 13550272
        end
      end

    elsif card_name =~ /^[#]/ #Get card legalities
      card_name = card_name.split('#')[1]
      url = "https://api.scryfall.com/cards/named?exact=#{card_name}"
      response = RestClient.get(url)

      body = JSON.parse(response)

      event.channel.send_embed do |embed|
        embed.title = body["name"] + " Legalities"
        embed.url = body["scryfall_uri"]
        
        

        body["legalities"].each do |magic_format, legalese|
          legality = ""
          if legalese == "not_legal"
            legality = "Not Legal"
          else
            legality = legalese.capitalize
          end
            
          embed.add_field(name: magic_format.capitalize, value: legality, inline: true)
        end

        if body["colors"][1]
          embed.color = 14799002
        elsif body["colors"][0] == "W"
          embed.color = 16579807
        elsif body["colors"][0] == "U"
          embed.color = 9622767
        elsif body["colors"][0] == "B"
          embed.color = 13484735
        elsif body["colors"][0] == "R"
          embed.color = 16754056
        elsif body["colors"][0] == "G"
          embed.color = 8772015
        else
          embed.color = 13550272
        end
      end
      
    else #Get card!
      url = "https://api.scryfall.com/cards/named?exact=#{card_name}"
      response = RestClient.get(url)

      body = JSON.parse(response)

      event.channel.send_embed do |embed|
        embed.title = body["name"] + " " + body["mana_cost"]
        # puts Manamoji.mana_parser(body["mana_cost"])

        embed.url = body["scryfall_uri"]

        embed.description = body["type_line"] + "\n" + body["oracle_text"]
        if body["power"]
          embed.description += "\n" + body["power"] + "/" + body["toughness"]
        elsif body["loyalty"]
          embed.description += "\n" + body["loyalty"]
        end

        embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: body["image_uris"]["normal"])
        if body["colors"][1]
          embed.color = 14799002
        elsif body["colors"][0] == "W"
          embed.color = 16579807
        elsif body["colors"][0] == "U"
          embed.color = 9622767
        elsif body["colors"][0] == "B"
          embed.color = 13484735
        elsif body["colors"][0] == "R"
          embed.color = 16754056
        elsif body["colors"][0] == "G"
          embed.color = 8772015
        else
          embed.color = 13550272
        end

      end

    end

  end

  bot.command(:exit, help_available: false) do |event|
    # This is a check that only allows a user with a specific ID to execute this command. Otherwise, everyone would be
    # able to shut your bot down whenever they wanted.
    break unless event.user.id == 238130012631334925

    bot.send_message(event.channel.id, 'Bot is shutting down')
    exit
  end

  bot.run(:async)

  bot.send_message(435592167449296903, 'Bot is now running!') #Sends message to the bot channel when start up (mostly so I know when i've actually restarted it)

  bot.sync

end