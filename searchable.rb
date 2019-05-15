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
    regexp = Regexp.union([' ', '"', "'"]) # Regexp for splitting search query by space or quotes
    @query_elements = @search_query.split(regexp).map(&:strip)

    return if @query_elements.empty?

    @results = @query_elements.one? ? results_by_single_word : results_by_multiple_words

    puts @results.any? ? @results : 'Nothing found'
  end

  def results_by_single_word
    @parsed_data.select { |record| record.values.grep(/#{@query_elements[0]}/).any? }
  end

  def results_by_multiple_words
    @parsed_data.reject do |record|
      # Reject all records which values does not contain matches with all of @query_elements
      @query_elements.map { |q| record.values.any? { |v| v.match?(/#{q}/)} }.include?(false)
    end
  end
end

Searchable.new.run_app
