#!/usr/bin/env ruby

require 'fileutils'
require 'open-uri'

class DotEnvInstaller
  def initialize
    @files_to_copy = [".rubocop.yml", ".hound.yml"]
    @src_path = "https://raw.githubusercontent.com/D32-rails/dottemplates/master/"
    @dest_path = File.expand_path File.dirname(__FILE__)
  end

  def install
    @files_to_copy.each do |file_name|
      puts "Creating: #{File.join(@dest_path, file_name)}"
      if write_file? file_name
        puts " -- Overwriting old #{file_name}"
        download_and_save(file_name)
      else
        puts " -- Skip! File exists, and overwrite is disabled"
      end
    end
  end

  private

  def write_file?(file_name)
    return overwrite? if File.exist?(file_name)
    true
  end

  def overwrite?
    !ARGV.include? "-n"
  end

  def download_and_save(file_name)
    open(file_name, 'w') do |file|
      file << open(@src_path + file_name).read
    end
  end
end

DotEnvInstaller.new.install if __FILE__ == $PROGRAM_NAME
