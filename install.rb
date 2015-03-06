#!/usr/bin/env ruby

require 'fileutils'

file_name = ".rubocop.yml"
file_path = File.join(File.expand_path File.dirname(__FILE__), file_name)
dest_path = "~/"

if File.exist?(File.expand_path(file_name))
  puts "File '#{File.join(dest_path,file_name)}' already exists. Overwrite? (y/n): "
  if gets.chomp[0].downcase != 'y'
    puts "Operation canceled."
    exit
  end
end

FileUtils.cp(file_path, File.expand_path(dest_path))
