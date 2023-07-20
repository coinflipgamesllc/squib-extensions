# Squib Extensions

Bonus functionality and shortcuts for working with [squib](https://squib.rocks). 

Include in your squib project:

```
bundle install squib-extensions
```

```ruby
require 'squib-extensions`
```

## Google Sheet

`gsheet` allows you to load Deck data using Google Sheets.

First, share your sheet using File > Publish to the web

Select 'Entire document' and '.csv' as the format

Copy the URL like
  
    https://docs.google.com/spreadsheets/d/e/2PACX-.../pub?output=csv
                                             ^^^^^^^^^
The code you need to pass is the long ID after /d/e.

If the sheet has multiple tabs, you can specify a later tab using the gid from the non-share URL like
  
    https://docs.google.com/spreadsheets/d/.../edit#gid=123456
                                                        ^^^^^^
The gid is at the end of the URL after #gid=

usage: 

```ruby
deck = Squib.gsheet('2PACX-1..., 123456789)

Squib::Deck.new(cards: deck['name'].size, layout: ["deck.yml"]) do
```

## Subset

Simplifies the format for taking a subset of rows and applying it to the `range` parameter.

Replace:

```ruby
one_widget = {} ; data['widgets'].each_with_index{ |w, i| if w == 1  one_widget[w] = i end }
text range: one_widget, str: deck['widgets'], layout: 'widget_label'
```

with

```ruby
one_widget = Squib.subset(deck['widgets'], -> (w) { w && w >= 1 })
text range: one_widget, str: deck['widgets'], layout: 'widget_label'
```

## Avatars

Renders an avatar SVG image using using https://avatars.dicebear.com/. Uses the SVG-specified units and DPI to determine the pixel width and height.  If neither data nor file are specified for a given card, this method does nothing.

usage:

```ruby
avatar seed: deck['image'], library: 'avataaars', layout: 'person'
```

result (if your seed is `Jack`): 

![](https://api.dicebear.com/6.x/avataaars/svg?seed=Jack)

## Card Number

Add the current card index to each card. Aids in locating the card in the CSV for making edits.

usage:

```ruby
card_num x: 730, y: 1035
```