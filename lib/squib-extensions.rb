require 'uri'
require 'net/http'
require 'squib'

module Squib
    # usage: deck = Squib.gsheet('2PACX-1..., 123456789)
    #
    # Downloads a CSV from google sheets and plugs it into squib's built-in CSV function.
    # The sheet must have a public CSV share URL.
    def gsheet(sheet_id, index=0)
        res = fetch("https://docs.google.com/spreadsheets/d/e/#{sheet_id}/pub?gid=#{index}&output=csv")

        if res.is_a?(Net::HTTPSuccess)
            data = res.body.force_encoding("utf-8").encode("ascii-8bit")
            return Squib.csv data: data
        else
            Squib.logger.error "Unable to fetch google sheet (error #{res.code}). Is '#{uri}' public?"
        end
    end
    module_function :gsheet

    # usage: one_widget = Squib.subset(deck['widgets'], -> (w) { w && w >= 1 })
    #
    # Takes a smaller subset of data based on some criteria. Can plug the output
    # directly into the range parameter for other module functions like svg, str, etc
    def subset(column, criteria, matching = true)
        sub = {}; column.each_with_index{ |c, i| (sub[criteria.(c)] ||= []) << i }

        return sub[matching]
    end
    module_function :subset

    class Deck
        # Generate an avatar
        def avatar(opts = {})
            DSL::Avatar.new(self, __callee__).run(opts)
        end

        # Adds a card number to aid in finding a card in a spreadsheet
        def card_num(opts = {})
            defaults = { x: self.width - 100, y: self.height - 100, width: 50, height: 50, font: 'sans-serif', font_size: 9, color: '#000', align: :center, valign: :middle }
            range = Args.extract_range opts, self

            # Add 2 because our csvs start at 1 and has a header row
            text(str: range.map{ |i| i+1 }, **(defaults.merge opts))
        end
    end

    module DSL
        class Avatar
            attr_reader :dsl_method, :deck

            def initialize(deck, dsl_method)
                @deck = deck
                @dsl_method = dsl_method
            end

            def run(opts)
                Dir.chdir(deck.img_dir) do
                    defaults = { library: 'avataaars' }
                    options = defaults.merge opts

                    # Extract the default svg options
                    range = Args.extract_range opts, deck
                    svg_args = Args.extract_svg_special opts, deck
                    paint = Args.extract_paint opts, deck
                    box   = Args.extract_scale_box opts, deck
                    trans = Args.extract_transform opts, deck

                    deck.progress_bar.start('Loading Avatar(s)', range.size) do |bar|
                        range.each do |i|
                            library = options[:library]
                            seed = options[:seed][i]
                            if seed == nil then
                                next
                            end

                            file = "avatar-#{library}-#{seed}.svg"

                            # Check if we need to download the image
                            if ! File.exist?(file) then
                                res = fetch("https://avatars.dicebear.com/api/#{library}/#{seed}.svg")
                                res = res.body.encode("ascii-8bit").force_encoding("utf-8")

                                File.open(file, "w") { |f| f.write(response) }
                            end

                            deck.cards[i].svg(file, svg_args[i], box[i], paint[i], trans[i])
                            bar.increment
                        end
                    end
                end
            end
        end
    end
end

def fetch(uri_str, limit = 10)
    raise ArgumentError, 'Too many redirects' if limit == 0

    url = URI.parse(uri_str)
    req = Net::HTTP::Get.new(uri_str)
    res = Net::HTTP.start(url.host, url.port, use_ssl: true) { |http| http.request(req) }
    case res
    when Net::HTTPRedirection then fetch(res['location'], limit - 1)
    else
      res
    end
end