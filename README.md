## ClowCards

A browser-based Heroscape card random-drafter.  To use, just supply a list of the players and the number of cards that each player should get, and click "Pick Cards!" to pick your cards.  Each card in the pool is selected at most once.  Without restarting the application, the cardset can be changed in realtime by toggling a card's draftability in the "Customize Cardset" area of the interface.

If you're interested in deploying this application via a single, minified `.js` file, run the `play start` command.  Then, patiently wait several minutes while RequireJS uglifies the code and builds the output file.

__Note__: Some cards are revised or renamed versions of official cards, and some others are entirely custom-made.  Usefulness to third parties may vary.  To appropriate the cardset to meet your needs, it shouldn't be too hard to customize the `/app/assets/javascripts/index/cards.coffee` file to properly represent your own cardset.
