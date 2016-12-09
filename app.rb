#!/usr/bin/env ruby

require 'json'

IMPORTANCE_POINTS = [0, 1, 10, 50, 250].freeze

file = File.read('./input.json')
hsh = JSON.parse(file)

# First attempt for matching
profiles = hsh['profiles']
results_hash = { results: [] }

# Add profileId and empty matches hash
# It would be better to give this value once both had calculated for one another
def build_results(profile, match_hsh)
  tmp_hsh = {
    profileId: profile['id'],
    matches: [
      match_hsh
    ]
  }

  results_hash['results'] << tmp_hsh
end

# walk through all profiles
def profile_walk(curr, comp)
  profile_walk(curr, comp + 1)

  answer_walk(profiles[curr], profiles[comp])
  # guard clause to return if we've iterated through the entire arr of profiles.
  return if profiles[curr] == profiles[-2]
  profile_walk(curr + 1, curr + 2) if profiles[comp] == profiles[-1]
end

# walk through all answers for profile A and B, default index values of 0
def answer_walk(profile_a, profile_b, curr = 0, comp = 0)
  question_id_a = profile_a['answers'][curr]['questionId']
  question_id_b = profile_a['answers'][comp]['questionId']

  if question_id_a !=  question_id_b
    answer_walk(prof_a, prof_b, curr, comp + 1) if profile_b['answers'][curr] != profile_b['answers'][-1]
  end

  answer_walk(prof_a, prof_b, curr + 1)
end

def compare_answers(answer_a, answer_b)
  if profile_a['answers'][curr]['acceptableAnswer'].include?(profile_b['answers'][comp]['answer'])
    determine_points(importance)
  end
  if profile_b['answers'][comp]['acceptableAnswer'].include?(profile_a['answers'][curr]['answer'])
    determine_points(importance)
  end

  # if final question, determine satifsaction
  # then pass curr and comp index to determine_matchmaking
  determine_satisfaction(current_points, max_points)
end

def determine_matchmaking(curr, comp, match_score)
  match_hsh = {
    profileId: profiles[comp]['id'],
    score: match_score
  }
  build_results(profiles[curr]['id'], match_hsh)

  match_hsh = {
    profileId: profiles[curr]['id'],
    score: match_score
  }
  build_results(profiles[comp]['id'], match_hsh)
end

def determine_points(importance, current_points = 0, current_max = 0)
  current_max + IMPORTANCE_POINTS[importance.to_i]
  current_points + IMPORTANCE_POINTS[importance.to_i]
end

def determine_satisfaction(earned, possible)
  Float(earned / possible)
end

def determine_match_score(satisfaction_a, Satisfaction_b)
  Math.sqrt(satisfaction_a, satisfaction_b)
end
