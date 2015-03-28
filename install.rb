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
      if File.exist?(file_name)
        if overwrite?
          puts " -- Overwriting old #{file_name}"
        else
          puts " -- Skip! File exists. To overwrite, run again with -f"
          next
        end
      end

      download_and_save(file_name)
    end
  end

  private

  def overwrite?
    ARGV.include? "-f"
  end

  def download_and_save(file_name)
    open(file_name, 'w') do |file|
      file << open(@src_path + file_name).read
    end
  end
end

DotEnvInstaller.new.install if __FILE__ == $PROGRAM_NAME
