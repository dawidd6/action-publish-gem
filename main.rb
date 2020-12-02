# frozen_string_literal: true

require 'fileutils'

def safe_system(*cmd)
  exit 1 unless system(*cmd)
end

api_key = ENV['API_KEY']
github_token = ENV['GITHUB_TOKEN']
github_repository_owner = ENV["GITHUB_REPOSITORY_OWNER"]
github_url = "https://rubygems.pkg.github.com/#{github_repository_owner}"

credentials_dir_path = "#{Dir.home}/.gem"
credentials_file_path = "#{credentials_dir_path}/credentials"
credentials = <<~END_OF_CREDENTIALS
  ---
  :rubygems_api_key: #{api_key}
  :github: Bearer #{github_token}
END_OF_CREDENTIALS

FileUtils.mkdir_p(credentials_dir_path)
File.open(credentials_file_path, 'w') { |f| f.write(credentials) }
FileUtils.chmod(0o600, credentials_file_path)

begin
  Dir.glob('*.gemspec').each do |gemspec_file|
    gemspec = Gem::Specification.load(gemspec_file)
    gem_file = gemspec.full_name + '.gem'
    safe_system('gem', 'build', gemspec_file)
    safe_system('gem', 'push', gem_file) unless api_key.empty?
    safe_system('gem', 'push', gem_file, "--key", "github", "--host", github_url) unless github_token.empty?
  end
ensure
  FileUtils.rm(credentials_file_path)
end