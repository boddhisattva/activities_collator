# frozen_string_literal: true

require 'uri'

namespace :scraper do
  desc 'Scrape events data from different websources'
  task scrape: :environment do
    web_sources.each do |web_source|
      uri = URI.parse(web_source[:events_url])
      web_source_base_url = "#{uri.scheme}://#{uri.host}"

      websource = WebSource.find_or_create_by!({ name: web_source[:name], url: web_source_base_url, scraper: web_source[:scraper] })

      Rails.logger.info "\n*********\nScraping: #{websource.url}\n************\n"

      web_source_scraper = Object.const_get(websource.scraper).new(websource)
      errors = web_source_scraper.scrape
      display_scraped_results(websource, errors)
    rescue StandardError => e
      Rails.logger.info "\n*********\nCould not find an existing Web Source or create a new Web Source\n*********\n"
      Rails.logger.info "\n*********\nError details: #{e.message}\n*********\n"
    end
  end
end

def web_sources
  [{ name: 'C/O Berlin', events_url: 'https://www.co-berlin.org/en/calender', scraper: 'CoBerlinScraper' },
   { name: 'Berghain', events_url: 'http://berghain.de/events/', scraper: 'BerghainScraper' }]
end

def display_scraped_results(web_source, errors)
  display_errors_related_info(web_source, errors) if errors.present?
  display_scraped_results_summary(web_source, errors)
end

def display_errors_related_info(web_source, errors)
  Rails.logger.info "\n*********\nErrors when scraping websource: #{web_source.url}\n*********\n"
  errors.each do |error|
    Rails.logger.info "\n*********\nError originating from Websource: #{error[:websource]} for activity type '#{error[:type]}'\n"
    Rails.logger.info "Error details: #{error[:message]}\n*********\n"
  end
end

def display_scraped_results_summary(web_source, errors)
  errors_count = errors.count
  puts "\n*********\nScraped results summary for websource: #{web_source.url} \n"
  puts "\nTotal number of errors: #{errors_count}\n*********\n"
  Rails.logger.info "\nScraped results summary for websource url: #{web_source.url}, " \
                    "Errors count: #{errors_count}\n*********\n"
end
