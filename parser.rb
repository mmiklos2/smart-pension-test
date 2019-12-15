require_relative 'lib/file_reader'
require_relative 'lib/data_analyzer'
require_relative 'lib/printer_service'

if ARGV.any?
	begin
	  pages_data = FileReader.call(ARGV.first)
	rescue ArgumentError => e
		puts e

		return
	end

	page_visits = DataAnalyzer.call(pages_data, unique: false)

	if page_visits.nil?
		puts 'No data found!'

		return
	end

	uniq_page_visits = DataAnalyzer.call(pages_data, unique: true)

	PrinterService.call(page_visits, 'visits')
	PrinterService.call(uniq_page_visits, 'unique_views')
else
	puts 'File path not provided, please provide one.' 
end