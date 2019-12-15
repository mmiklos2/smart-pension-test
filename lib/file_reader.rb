# frozen_string_literal: true

require_relative 'abstract_reader'

class FileReader < AbstractReader
  ARG_TYPE_ERROR = "Please provide a '.log' file."
  VALID_EXT = '.log'

  def initialize(log_path)
    @file_data = {}

    super(log_path)
  end

  def call
    read_file if file_valid?
  end

  private

  def read_file
    File.open(@resource_path, 'r').each_line do |log_entry|
      record_page_visit(*log_entry.split("\s"))
    end.close

    @file_data
  end

  def record_page_visit(page_visited, visitor)
    @file_data[page_visited] ||= []

    @file_data[page_visited].push(visitor)
  end

  def file_valid?
    file_exists? && format_valid?
  end

  def format_valid?
    is_valid = File.extname(@resource_path) == VALID_EXT
    is_valid || raise(ArgumentError, ARG_TYPE_ERROR)
  end

  def file_exists?
    file_exists = File.exist?(@resource_path)
    error_report = "#{@resource_path} not found. Provide an existing file."
    file_exists || raise(ArgumentError, error_report)
  end
end
