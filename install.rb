#!/usr/bin/env ruby

require 'fileutils'
require 'open-uri'

file_name = ".rubocop.yml"
src_path = "https://raw.githubusercontent.com/D32-rails/dottemplates/master/.rubocop.yml"
dest_path = "~/"

FileUtils.cd File.expand_path(dest_path)

if File.exist?(file_name)
  puts "File '#{File.join(dest_path,file_name)}' already exists. Overwrite? (y/n): "
  if gets.chomp[0].downcase != 'y'
    puts "Install cancelled."
    exit
  end
end

open(file_name, 'w') do |file|
  file << open(src_path).read
end

puts "Rubocop config successfully installed to #{File.expand_path(dest_path, file_name)}"
