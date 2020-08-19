
require 'bundler'
require "dotenv/load"
require "open-uri"
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/recipe_ruby.db')
require_all 'app'
require_all 'lib'
require_relative 'keys.rb'
PROMPT = TTY::Prompt.new
ActiveRecord::Base.logger = nil