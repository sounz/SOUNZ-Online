#!/usr/bin/ruby

STDIN.readlines.each do |l|
  m = l.match /^(\S+) \((.*)\)/
  unless m.nil?
    gem_name, versions = m[1], m[2].split(',')
    versions.each do |v|
      system "gem install #{gem_name} --version #{v} --ignore-dependencies"
    end
  end
end
