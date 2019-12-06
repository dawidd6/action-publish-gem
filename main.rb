#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'

def safe_system(*cmd)
  exit 1 unless system(*cmd)
end

api_key = ENV['INPUT_API_KEY'] || 'dummy'
gemspec_files = Dir.glob('*.gemspec')
credentials_dir_path = "#{Dir.home}/.gem"
credentials_file_path = "#{credentials_dir_path}/credentials"
credentials = <<~END_OF_CREDENTIALS
  ---
  :rubygems_api_key: #{api_key}
END_OF_CREDENTIALS

FileUtils.mkdir_p(credentials_dir_path)
File.open(credentials_file_path, 'w') { |f| f.write(credentials) }
FileUtils.chmod(0o600, credentials_file_path)

gemspec_files.each do |gemspec_file|
  gemspec = Gem::Specification.load(gemspec_file)
  gem_file = gemspec.full_name + '.gem'
  safe_system('gem', 'build', gemspec_file)
  safe_system('gem', 'push', gem_file)
end
