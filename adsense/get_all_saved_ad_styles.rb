#!/usr/bin/env ruby
# Encoding: utf-8
#
# Author:: sgomes@google.com (Sérgio Gomes)
#
# Copyright:: Copyright 2013, Google Inc. All Rights Reserved.
#
# License:: Licensed under the Apache License, Version 2.0 (the "License");
#           you may not use this file except in compliance with the License.
#           You may obtain a copy of the License at
#
#           http://www.apache.org/licenses/LICENSE-2.0
#
#           Unless required by applicable law or agreed to in writing, software
#           distributed under the License is distributed on an "AS IS" BASIS,
#           WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
#           implied.
#           See the License for the specific language governing permissions and
#           limitations under the License.
#
# This example gets all the saved ad styles for the logged in user's default
# account.
#
# Tags: savedadstyles.list

require 'adsense_common'

# The maximum number of results to be returned in a page.
MAX_PAGE_SIZE = 50

def get_all_saved_ad_styles(adsense)
  request = adsense.savedadstyles.list(:maxResults => MAX_PAGE_SIZE)

  loop do
    result = request.execute

    result.data.items.each do |saved_ad_style|
      ad_style = saved_ad_style.ad_style
      puts 'Saved ad style with ID "%s" and background color "#%s" was found.' %
        [saved_ad_style.id, ad_style.colors.background]

      if ad_style['corners'] && ad_style['font']
        puts '  It has "%s" corners and a "%s" size font.' %
          [ad_style.corners, ad_style.font.size]
      end
    end

    break unless result.next_page_token
    request = result.next_page
  end
end


if __FILE__ == $0
  adsense = service_setup()
  get_all_saved_ad_styles(adsense)
end
