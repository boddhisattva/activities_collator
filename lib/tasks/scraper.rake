# frozen_string_literal: true

namespace :scraper do
  desc 'Scrape events data from different websources'
  task scrape: :environment do
    web_sources.each do |web_source|
      websource = WebSource.find_or_create_by!({ name: web_source[:name], url: web_source[:url], scraper: web_source[:scraper] })

      Rails.logger.info "\n*********\nScraping: #{websource.url}\n************\n"

      web_source_scraper = Object.const_get(websource.scraper).new(websource)
      items_scraped_count, errors = web_source_scraper.scrape
      display_scraped_results(websource, items_scraped_count, errors)
    rescue StandardError => e
      Rails.logger.info "\n*********\nCould not find an existing Web Source or create a new Web Source\n*********\n"
      Rails.logger.info "\n*********\nError details: #{e.message}\n*********\n"
    end
  end
end

def web_sources
  [{ name: 'C/O Berlin', url: 'https://www.co-berlin.org/en/calender', scraper: 'CoBerlinScraper' },
   { name: 'Berghain', url: 'http://berghain.de/events/', scraper: 'BerghainScraper' }]
end

def display_scraped_results(web_source, items_scraped_count, errors)
  display_items_scraped_related_info(web_source, items_scraped_count)
  display_errors_related_info(web_source, errors) if errors.present?
  display_scraped_results_summary(web_source, items_scraped_count, errors)
end

def display_items_scraped_related_info(web_source, items_scraped_count)
  items_scraped_count.each do |item_type, items_count|
    Rails.logger.info "\n*********\nNumber of Items of type '#{item_type}' scraped for #{web_source.url}: #{items_count}\n*********\n"
  end
end

def display_errors_related_info(web_source, errors)
  Rails.logger.info "\n*********\nErrors when scraping websource: #{web_source.url}\n*********\n"
  errors.each do |error|
    Rails.logger.info "\n*********\nError originating from Websource: #{error[:websource]} for activity type '#{error[:type]}'\n"
    Rails.logger.info "Error details: #{error[:message]}\n*********\n"
  end
end

def display_scraped_results_summary(web_source, items_scraped_count, errors)
  total_items_scraped = items_scraped_count.values.sum
  errors_count = errors.count
  puts "\n*********\nScraped results summary for websource: #{web_source.url} \n"
  puts "\nTotal number of items scraped: #{total_items_scraped}\n"
  puts "\nTotal number of errors: #{errors_count}\n*********\n"
  Rails.logger.info "\nScraped results summary: \n*********\nTotal number of items scraped for #{web_source.url}: #{total_items_scraped}, " \
                    "Errors count: #{errors_count}\n*********\n"
end
