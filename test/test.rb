#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../parser'
require_relative '../log_printer'
require_relative '../log_processor'

class TestParser < Minitest::Test
  def test_run
    expected = <<~STR.strip
      WEBPAGES WITH MOST PAGE VIEWS:

      /about/2 - 90 visits
      /contact - 89 visits
      /index - 82 visits
      /about - 81 visits
      /help_page/1 - 80 visits
      /home - 78 visits

      WEBPAGES WITH MOST UNIQUE PAGE VIEWS:

      /index - 23 unique views
      /home - 23 unique views
      /contact - 23 unique views
      /help_page/1 - 23 unique views
      /about/2 - 22 unique views
      /about - 21 unique views

      AVERAGE VIEWS:

      /about/2 - 4 average per view
      /about - 3 average per view
      /index - 3 average per view
      /home - 3 average per view
      /contact - 3 average per view
      /help_page/1 - 3 average per view
    STR
    actual = Parser.new('webserver.log').run.to_s

    assert_equal expected, actual
    assert_includes(actual, '/about/2')
  end

  def test_run_table
    expected = <<~STR.strip
      WEBPAGES WITH MOST PAGE VIEWS:

      |     /about/2 | 90 visits |
      |     /contact | 89 visits |
      |       /index | 82 visits |
      |       /about | 81 visits |
      | /help_page/1 | 80 visits |
      |        /home | 78 visits |

      WEBPAGES WITH MOST UNIQUE PAGE VIEWS:

      |       /index | 23 unique views |
      |        /home | 23 unique views |
      |     /contact | 23 unique views |
      | /help_page/1 | 23 unique views |
      |     /about/2 | 22 unique views |
      |       /about | 21 unique views |

      AVERAGE VIEWS:

      |     /about/2 | 4 average per view |
      |       /about | 3 average per view |
      |       /index | 3 average per view |
      |        /home | 3 average per view |
      |     /contact | 3 average per view |
      | /help_page/1 | 3 average per view |

    STR
    actual = Parser.new('webserver.log', log_printer: LogPrinter::Table).run.to_s

    assert_equal expected, actual
    assert_includes(actual, '/about/2')
  end

  def test_processor_returns_an_hash
    assert_kind_of Hash, processed_log
  end

  def test_processor_returns_object
    refute_empty processed_log
  end

  def test_log_printer_returns_hash
    assert_kind_of Hash, log_printer_response
  end

  def test_log_printer_returns_object
    refute_empty log_printer_response
  end

  private

  def log_printer_response
    log_printer_response = LogPrinter.new(processed_log)
    log_printer_response.page_stats
  end

  def processed_log
    LogProcessor.new('webserver.log').process
  end
end




