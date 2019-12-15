require_relative './abstract_service'

class DataAnalyzer < AbstractService
  def initialize(page_visits, unique: false)
    @page_visits = page_visits
    @unique = unique
  end

  def call
    return nil if @page_visits.empty?

    format_data
  end

  private

  def format_data
    @page_visits.transform_values do |value|
      value = value.uniq if @unique
      value.length
    end.sort_by { |_, v| v }.reverse.to_h
  end
end