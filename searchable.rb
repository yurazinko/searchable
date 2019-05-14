require 'json'
require 'pry'

class Searchable
  def run_app
    prompt_user_input
    parse_data_from_file
    collect_search_results
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

  def collect_search_results
    puts @parsed_data.select { |record| record.values.grep(/#{@search_query}/).any? }
  end
end

Searchable.new.run_app
