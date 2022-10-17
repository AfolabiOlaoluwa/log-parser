#!/usr/bin/ruby
# frozen_string_literal: true

require './log_processor'

class LogPrinter
  attr_reader :page_stats

  def initialize(page_stats)
    @page_stats = page_stats
  end

  def to_s
    [
      'WEBPAGES WITH MOST PAGE VIEWS:',
      fmt(:page_views, 'visits'),
      'WEBPAGES WITH MOST UNIQUE PAGE VIEWS:',
      fmt(:unique_page_views, 'unique views'),
      'AVERAGE VIEWS:',
      fmt(:average_page_view, 'average per view')
    ].join("\n\n")
  end

  class List < LogPrinter
    def fmt(key, count_label)
      hash = page_stats.transform_values { |stats| stats.send(key) }.sort_by(&pair_arr_sort).reverse
      hash.map { |path, value| "#{path} - #{value} #{count_label}" }.join("\n")
    end
  end

  class Table < LogPrinter
    def fmt(key, value_label)
      hash = page_stats.transform_values { |stats| stats.send(key) }.sort_by(&pair_arr_sort).reverse
      key_max_size = hash.to_h.keys.map(&:size).max
      value_max_size = hash.to_h.values.map(&:to_s).map(&:size).max
      hash.map do |path, uniq_ips|
        format("| %#{key_max_size}s | %#{value_max_size}s %s |", path, uniq_ips, value_label)
      end.join("\n")
    end
  end

  private

  def pair_arr_sort
    ->((_k, v)) { v }
  end
end
