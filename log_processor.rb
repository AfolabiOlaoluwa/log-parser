#!/usr/bin/ruby
# frozen_string_literal: true

require 'ostruct'

class LogProcessor
  LogEvent = Struct.new(:path, :ip)

  def initialize(file_name)
    @file_name = file_name
  end

  def process
    log_events = File.readlines(@file_name).map { |line| LogEvent.new(*line.split) }
    log_events.group_by(&:path).transform_values do |events|
      ips = events.map(&:ip)
      OpenStruct.new(
        page_views: ips.count,
        unique_page_views: ips.uniq.count
      )
    end
  end
end
