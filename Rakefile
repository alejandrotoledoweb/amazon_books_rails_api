# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"
require "syntax_tree/rake_tasks"

Rails.application.load_tasks

SyntaxTree::Rake::CheckTask.new
SyntaxTree::Rake::WriteTask.new { |t| t.plugins = ["plugin/single_quotes"] }
