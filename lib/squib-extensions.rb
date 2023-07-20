require 'uri'
require 'net/http'
require 'squib'

module Squib
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