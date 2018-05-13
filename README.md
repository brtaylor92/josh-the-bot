# Installation
The easiest method is to clone this codebase using github.

Then, inside of the main directory create a `config.yaml` file, and add the text `DISCORD_TOKEN: <your-token-here>`. If you don't know how to get a discord token, you can go [here](https://discordapp.com/developers/applications/me), create an app, make a bot account for it, and use the token generated for that bot.

Make sure you `bundle` in your terminal inside of the directory for your bot before you, again in your terminal, use `ruby run.rb` to start the bot up. (Make sure to invite it to your server!)

## Recognitions

This bot is built using the ruby gem [discordrb](https://github.com/meew0/discordrb), where you can find a lot of information about setting up your own bot and building new functionality into it!

And a lot of the features of this bot are modeled on those in the [Scryfall Discord bot](https://scryfall.com/bots), though I lovingly ripped off some code from their original version which is both written in javascript (mine is in ruby, so some translation work was involved) and can be found [here](https://github.com/scryfall/servo).
