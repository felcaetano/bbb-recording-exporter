#!/usr/bin/env ruby
# frozen_string_literal: false

require "fileutils"

published_folder = "/var/bigbluebutton/published/presentation/"
export_script = "/usr/local/bigbluebutton/core/scripts/post_publish/export_presentation.rb"

allmeetings = Dir.entries("#{published_folder}")

allmeetings.each do |meetingid|
  unless File.exist?("#{published_folder}/#{meetingid}/meeting.mp4")
    if File.exist?("#{published_folder}/#{meetingid}/metadata.xml")
      puts "Processing : #{meetingid}"
      system("#{export_script} -m #{meetingid}")
      FileUtils.chown_R 'bigbluebutton', 'bigbluebutton', "#{published_folder}/#{meetingid}/"
    end
  end
end
