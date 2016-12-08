#!/usr/bin/env ruby

require 'json'

# module for OKCupid json parsing
module OKCupid
  IMPORTANCE_POINTS = [0, 1, 10, 50, 250].freeze

  file = File.read('./input.json')
  OK_FILE = JSON.parse(file)
end

# First attempt for matching
data_hash = OK_FILE.clone
results_hash = { results: [] }

# Sort profiles by id, and sort answers by questionId
sorted_profiles = data_hash['profiles'].sort do |a, b|
  a['id'] <=> b['id']
end.each do |profile| # sort questionId
  profile['answers'].sort! { |a, b| a['questionId'] <=> b['questionId'] }
end
# recursive function to create matches.  Find questionIds in common,
# compare answer and acceptable, gauge importance if 1..3, and
# calculate matchRank from existing values (match rank is bi-directional)
sorted_profiles.each_with_index do |profiles, i|
  return if profile[i] == profile[-1]
  profile[i]['answers'].each_with_index do |ans, j|
    return if ans[j] == ans[-1]

  end
end
