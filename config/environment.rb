
require 'bundler'
require "dotenv/load"
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/recipe_ruby.db')
require_all 'app'
require_all 'lib'
require_relative 'api.rb'
PROMPT = TTY::Prompt.new