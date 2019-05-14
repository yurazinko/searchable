require 'json'

class Searchable
  def run_app
    prompt_user_input
    parse_data_from_file
  end

  def prompt_user_input
    puts "\n Provide file name with data"
    @file_path = "/#{gets.chomp}"

    puts "\n Provide your search query"
    @search_query = gets.chomp
  end

  def parse_data_from_file
    file = File.read(@file_path)
    @parsed_data = JSON.parse(file)
    puts @parsed_data
  end
end

Searchable.new.run_app
