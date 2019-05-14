require 'json'
require 'pry'

class Searchable
  def run_app
    prompt_user_input
    parse_data_from_file
  end

  def prompt_user_input
    puts "\n Provide your file path"
    users_input = gets.chomp
    @file_path = users_input.empty? ? 'data.json' : users_input
    puts "\n Provide your search query"
    @search_query = gets.chomp
  end

  def parse_data_from_file
    @parsed_data = JSON.parse(File.read(@file_path))
  end
end

Searchable.new.run_app
