#!/usr/bin/ruby

require './regex'

def binyan_definitions
  {
    paal: "Paal is a simple action.  Subject does verb to object.",
    piel: "Piel is an intensive action.  Subject does verb to object, but more intensely than in paal.  For example, broke vs. shattered.  Not all verbs have both a piel and a paal form, in which case piel is a simple action."
  }
end

def build_definition form, root
  "This word is in #{form[:tense]} tense.  It is in #{form[:person]} person, and #{form[:number]}.  The subject is #{form[:gender]}.  It is in #{form[:binyan]} form, which means: #{binyan_definitions[form[:binyan]]}" 
end

#$~ is the matchdata of the last regex match.
#match[0] is the full match, match[1] is the first group matched.
#In this case, that's the shoresh.
def translate word
  regex_dictionary = Regex.regex_dictionary
  regex_dictionary.each do |regex, form|
    puts regex
    if regex.match word
      return build_definition form, $~[1..-1].join
    end
  end
end

result = translate ARGV[0]
puts result
