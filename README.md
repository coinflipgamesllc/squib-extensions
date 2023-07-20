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

result (maybe!): 

<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 280 280" fill="none" shape-rendering="auto" width="512" height="512"><desc>"Avataaars" by "Pablo Stanley", licensed under "Free for personal and commercial use". / Remix of the original. - Created with dicebear.com</desc><metadata xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:cc="http://creativecommons.org/ns#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"><rdf:RDF><cc:Work><dc:title>Avataaars</dc:title><dc:creator><cc:Agent rdf:about="https://twitter.com/pablostanley"><dc:title>Pablo Stanley</dc:title></cc:Agent></dc:creator><dc:source>https://avataaars.com/</dc:source><cc:license rdf:resource="https://avataaars.com/" /></cc:Work></rdf:RDF></metadata><mask id="viewboxMask"><rect width="280" height="280" rx="0" ry="0" x="0" y="0" fill="#fff" /></mask><g mask="url(#viewboxMask)"><g transform="translate(8)"><path d="M132 36a56 56 0 0 0-56 56v6.17A12 12 0 0 0 66 110v14a12 12 0 0 0 10.3 11.88 56.04 56.04 0 0 0 31.7 44.73v18.4h-4a72 72 0 0 0-72 72v9h200v-9a72 72 0 0 0-72-72h-4v-18.39a56.04 56.04 0 0 0 31.7-44.73A12 12 0 0 0 198 124v-14a12 12 0 0 0-10-11.83V92a56 56 0 0 0-56-56Z" fill="#fd9841"/><path d="M108 180.61v8a55.79 55.79 0 0 0 24 5.39c8.59 0 16.73-1.93 24-5.39v-8a55.79 55.79 0 0 1-24 5.39 55.79 55.79 0 0 1-24-5.39Z" fill="#000" fill-opacity=".1"/><g transform="translate(0 170)"><path d="M196 38.63V110H68V38.63a71.52 71.52 0 0 1 26-8.94v44.3h76V29.69a71.52 71.52 0 0 1 26 8.94Z" fill="#ffafb9"/><path d="M86 83a5 5 0 1 1-10 0 5 5 0 0 1 10 0ZM188 83a5 5 0 1 1-10 0 5 5 0 0 1 10 0Z" fill="#F4F4F4"/></g><g transform="translate(78 134)"><path fill-rule="evenodd" clip-rule="evenodd" d="M35.12 15.13a19 19 0 0 0 37.77-.09c.08-.77-.77-2.04-1.85-2.04H37.1C36 13 35 14.18 35.12 15.13Z" fill="#000" fill-opacity=".7"/><path d="M70 13H39a5 5 0 0 0 5 5h21a5 5 0 0 0 5-5Z" fill="#fff"/><path d="M66.7 27.14A10.96 10.96 0 0 0 54 25.2a10.95 10.95 0 0 0-12.7 1.94A18.93 18.93 0 0 0 54 32c4.88 0 9.33-1.84 12.7-4.86Z" fill="#FF4F6D"/></g><g transform="translate(104 122)"><path fill-rule="evenodd" clip-rule="evenodd" d="M16 8c0 4.42 5.37 8 12 8s12-3.58 12-8" fill="#000" fill-opacity=".16"/></g><g transform="translate(76 90)"><path d="M16.16 27.55c1.85 3.8 6 6.45 10.84 6.45 4.81 0 8.96-2.63 10.82-6.4.55-1.13-.24-2.05-1.03-1.37a15.05 15.05 0 0 1-9.8 3.43c-3.73 0-7.12-1.24-9.55-3.23-.9-.73-1.82.01-1.28 1.12ZM74.16 27.55c1.85 3.8 6 6.45 10.84 6.45 4.81 0 8.96-2.63 10.82-6.4.55-1.13-.24-2.05-1.03-1.37a15.05 15.05 0 0 1-9.8 3.43c-3.74 0-7.13-1.24-9.56-3.23-.9-.73-1.82.01-1.28 1.12Z" fill-rule="evenodd" clip-rule="evenodd" fill="#000" fill-opacity=".6"/></g><g transform="translate(76 82)"><path d="m22.77 1.58.9-.4C28.93-.91 36.88-.03 41.73 2.3c.57.27.18 1.15-.4 1.1-14.92-1.14-24.96 8.15-28.37 14.45-.1.18-.41.2-.49.03-2.3-5.32 4.45-13.98 10.3-16.3ZM87 12.07c5.75.77 14.74 5.8 13.99 11.6-.03.2-.31.26-.44.1-2.49-3.2-21.71-7.87-28.71-6.9-.64.1-1.07-.57-.63-.98 3.75-3.54 10.62-4.52 15.78-3.82Z" fill-rule="evenodd" clip-rule="evenodd" fill="#000" fill-opacity=".6"/></g><g transform="translate(-1)"><path d="m175.83 55.92-.03.02c.76.88 1.49 1.78 2.19 2.7a55.74 55.74 0 0 1 11 33.36v5.5c0-15.77-6.69-29.98-17.4-39.93-11.58 3.77-49.58 14.27-77.63.42A54.35 54.35 0 0 0 77 97.5V92c0-12.5 4.1-24.04 11.01-33.35.71-.94 1.45-1.86 2.22-2.75l-.02-.02A55.88 55.88 0 0 1 133 36a55.88 55.88 0 0 1 42.82 19.92Z" fill="#000" fill-opacity=".16"/><path d="M92.54 53.29A55.81 55.81 0 0 0 77 91.99v6.17a11.97 11.97 0 0 0-6.49 3.34l.7-17.37a45.92 45.92 0 0 1 17.37-34.17c-2.2-3.84-1.45-10.33 7.8-13.1 5.07-1.5 7.57-5.08 10.24-8.88 3.5-5 7.27-10.37 17.48-11.92 9.87-1.5 13.23-.88 17.05-.18 3.13.57 6.58 1.2 14.2.76 9.85-.57 16.86-4 21.43-6.22 3.26-1.6 5.27-2.58 6.17-1.47 15.42 18.9 6.97 33.8-6.2 41.96A45.9 45.9 0 0 1 193 86v13.6c-1.22-.7-2.56-1.2-4-1.43V92c0-15.26-6.1-29.09-16-39.19-7.76 2.75-50.39 16.55-80.46.48ZM223.61 226.05c3.06 5.6 4.05 11.12 3.5 16.38A72.02 72.02 0 0 0 161 199h-4v-18.39a56.03 56.03 0 0 0 31.8-45.74c1.5-.23 2.93-.74 4.2-1.47v20.7c0 20.77 11.47 39.79 22.15 57.47 2.97 4.93 5.88 9.75 8.46 14.48ZM68.7 146.5l.66-16.35a12 12 0 0 0 7.85 4.72A56.03 56.03 0 0 0 109 180.6V199h-4c-11.2 0-21.8 2.56-31.25 7.12-2.99-18.29-4.3-38.68-5.05-59.62Z" fill="#a55728"/><path fill-rule="evenodd" clip-rule="evenodd" d="M90.88 52.36c33.22 19.3 83.37 0 83.37 0 14.53-7.77 25.08-23.32 8.7-43.4-2.17-2.66-10.7 6.72-27.6 7.7-16.9.97-13.27-3.31-31.25-.59-17.97 2.73-15.99 17.3-27.72 20.8-11.73 3.5-9.8 13-5.5 15.5Z" fill="#fff" fill-opacity=".2"/></g><g transform="translate(49 72)"></g><g transform="translate(62 42)"></g></g></g></svg>

## Card Number

Add the current card index to each card. Aids in locating the card in the CSV for making edits.

usage:

```ruby
card_num x: 730, y: 1035
```