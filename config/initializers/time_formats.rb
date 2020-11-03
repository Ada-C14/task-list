
Time::DATE_FORMATS[:twelvehr_long_ordinal] = lambda do |time|
  day_format = ActiveSupport::Inflector.ordinalize(time.day)
  time.strftime("%B #{day_format}, %I:%M %p")
end