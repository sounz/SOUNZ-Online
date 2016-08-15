require 'rubygems'
  require 'google_geocode'
  require 'yaml'
  
module GeographyHelper
  

def self.parse_address(desired_address)
    #Key for 127.0.0.1
    gg = GoogleGeocode.new 'ABQIAAAA0cJpnWSrLTBmLnxPL4nExBTX2XchcwgyHzp4Xo0DHRAzt2aLjhQQr2vWuuCy6CUVfk_5bsJzQrUfog'
    location = gg.locate desired_address
    p location
    return location
  
end


def self.parse_contactinfo_file()
    filepath = '/Users/gordon/Documents/workspace/Sounz/sounz/test/fixtures/contactinfos.yml'
  conf2 = open(filepath){|f| YAML.load(f)}
  conf2.each{|k,v| 
    #puts "#{k} => #{v['internal_note']}"
    address = v['internal_note'].strip!
    if address.blank?
      address = v['street']+' ' +v['locality']
    end
    puts k+":"  
    address.strip!
    if !address.blank?  
      address = address + " , New Zealand"
    end
    begin
      location = parse_address(address)
      lat = location[1]
      lon = location[2]
      puts "  #latitude: #{lat}"
      puts "  #longitude: #{lon}"
      begin
      google_address = location[0]
      puts "#ORIG ADDRESS:#{address}"
      puts "#GOOGLE ADDRESS:#{google_address}"
      splits = google_address.split(',')
      street = splits[0]
      locality = splits[1]
      postcode = splits[-2].split(' ')[-1]
  #    suburb = splits[-2].split(' ')[0]
      
      v['street'] = street
      v['locality'] = locality
      
      puts "  postcode: #{postcode}"
      
      internal_note = v['internal_note']
      new_internal_note = internal_note+" [GOOGLE GEOCODED ADDRESS is #{google_address}]"
      v['internal_note'] = new_internal_note
      rescue
        puts "#Could not convert result to a postcode"
      end
    rescue
      puts "#FIXME: Could not parse #{address}"
    end
    

    for kv in v.keys
        puts "  #{kv}: #{v[kv]}"
    end
    
    puts "\n\n\n#============="
  #  puts k.to_yaml
    }
    ""
end


=begin
require 'rubygems'
  require 'google_geocode'
  gg = GoogleGeocode.new 'ABQIAAAA0cJpnWSrLTBmLnxPL4nExBTX2XchcwgyHzp4Xo0DHRAzt2aLjhQQr2vWuuCy6CUVfk_5bsJzQrUfog'
  location = gg.locate '1600 Amphitheater Pkwy, Mountain View, CA'
  p location.coordinates
=end
  

end