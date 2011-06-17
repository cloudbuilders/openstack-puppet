# mangled off extlookup.rb
# 

require 'yaml'
module Puppet::Parser::Functions
  newfunction(:configval, :type => :rvalue) do |args|
    parser = Puppet::Parser::Parser.new(environment)

    def var_to_fact str
      while str =~ /%\{(.+?)\}/
        fact = lookupvar $1
        raise(Puppet::ParseError, "Unable to found value for #{str}") if fact.nil?
        str.gsub!(/%\{#{$1}\}/, fact)
      end
      str
    end

    lookup_debug = true if lookupvar('lookup_debug?') == true

    raise(Puppet::ParserError, "Wrong number of args to configval") unless (args.length == 2 || args.length == 3)
      
    key = args[0]
    lookup_file = args[1]
    default_value = args.length == 3 ? args[2] : nil

    file = lookup_file.start_with?("/") ? lookup_file : "/etc/puppet/#{lookup_file}.yaml" 

    raise(Puppet::ParseError, "Can't find input yaml file: #{file}") unless File.exist?(file)

    parser.watch_file file
    begin
      result = YAML.load_file(file)[key]
      if result and result.size > 0
        result.to_a.map! { |r| var_to_fact r } # replace values to facts if required.
      end
    rescue
      raise Puppet::ParseError, "Something went wrong while parsing #{file} - #{$!}"
    end

    if result.size > 0
      return result
#      return result.size == 1 ? result.to_s : result
    else
      raise(Puppet::ParseError, "Could not find #{key}") if default_value == nil
      return default_value
    end
  end
end
