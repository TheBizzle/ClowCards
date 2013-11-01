# ClowCards

## What Is It?

It's a browser-based Heroscape card random-drafter!  To draft, simply supply one or more player names and a number of cards to be drafted for each player, and then click "Pick Cards!".  Each card in the pool is selected at most once.  Without restarting the application, the cardset can be changed in realtime by toggling a card's draftability in the "Customize Cardset" area of the interface.

**CURRENTLY BROKEN (see [here](https://github.com/TheBizzle/ClowCards/issues/19))**: If you're interested in deploying this application via a single, minified `.js` file, run the `play start` command.  Then, patiently wait several minutes while RequireJS uglifies the code and builds the output file.  Once that's done, Play will handle the rest for you.

## Disclaimer

Some cards are revised or renamed versions of official cards, and some others are entirely custom-made.  **Usefulness to third parties may vary.**  To appropriate the cardset to meet your needs, it shouldn't be too hard to customize the `/app/assets/javascripts/index/cards.coffee` file to properly represent your own cardset.
