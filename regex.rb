module Regex
  def self.regex_dictionary
    regexes = {}
    regexes.merge! generate_past_regexes
    regexes.merge! generate_present_regexes
    regexes.merge! generate_future_regexes 
    return regexes
  end

  def self.generate_future_regexes
    def self.future_regexes binyan, name 
      {
        /^א#{binyan}$/ => {tense: :future, person: :first, number: :singular, binyan: name, gender: :neuter},
        /^ת#{binyan}$/ => {tense: :future, person: [:second, :third], number: :singular, binyan: name, gender: [:male, :female]},
        /^ת#{binyan.sub('ו', '')}י$/ => {tense: :future, person: :second, number: :singular, binyan: name, gender: :female},
        /^י#{binyan}$/ => {tense: :future, person: :third, number: :singular, binyan: name, gender: :neuter},
        /^נ#{binyan}$/ => {tense: :future, person: :first, number: :singular, binyan: name, gender: :neuter},
        /^ת#{binyan.sub('ו', '')}ו$/ => {tense: :future, person: :first, number: :singular, binyan: name, gender: :neuter},
        /^י#{binyan.sub('ו', '')}ו$/ => {tense: :future, person: :third, number: :singular, binyan: name, gender: :neuter}
      }
    end

    regexes = {}
    paal = '(.)ו(..)'
    piel = '(...)'
    regexes.merge!(future_regexes(paal, :paal))
    regexes.merge!(future_regexes(piel, :piel))
    
    return regexes
  end

  def self.generate_present_regexes
    present_endings =
      [
        {'' => {tense: :present, person: :unknown, number: :singular, gender: :male}},
        {'ת' => {tense: :present, person: :unknown, number: :singular, gender: :female}},
        {'ים' => {tense: :present, person: :unknown, number: :plural, gender: :male}},
        {'ות' => {tense: :present, person: :unknown, number: :plural, gender: :female}}
      ]

    regexes = {}
    present_endings.each do |suffix|
      ending, form = suffix.keys[0], suffix.values[0]
      regexes.merge!({/^מ(...)#{ending}$/ => form.merge({binyan: :piel})})
      regexes.merge!({/^(.)ו(..)#{ending}$/ => form.merge({binyan: :paal})})
    end
    return regexes
  end

  def self.generate_past_regexes
    binyanim =
      [[:paal, /(...)/],
       [:nifal, /נ(...)/],
       [:piel, /(.)י(..)/],
       [:pual, /(.)ו(..)/],
       [:hifil, /ה(..)י(.)/],
       [:hufal, /הו(...)/],
       [:hitpael, /הת(...)/]
      ]
    past_endings =
      [
        {'תי' =>{tense: :past, person: :first, number: :singular, gender: :neuter}},
        {'ת' => {tense: :past, person: :second, number: :singular, gender: :neuter}},
        {'' => {tense: :past, person: :third, number: :singular, gender: :male}},
        {'ה' => {tense: :past, person: :third, number: :singular, gender: :female}},
        {'תם' => {tense: :past, person: :second, number: :plural, gender: :male}},
        {'תן' => {tense: :past, person: :second, number: :plural, gender: :female}},
        {'נו' => {tense: :past, person: :first, number: :plural, gender: :neuter}},
        {'ו' => {tense: :past, person: :third, number: :plural, gender: :neuter}},
      ]
    regexes = {}
    past_endings.each do |suffix|
      ending, form = suffix.keys[0], suffix.values[0]
      binyanim.each do |binyan|
        name, regex = binyan
        regexes.merge!({/^#{regex}#{ending}$/ => form.merge({binyan: name})})
      end
    end

    return regexes
  end

  
end
