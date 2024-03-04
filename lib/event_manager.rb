# ASSIGNMENT: CLEAN PHONE NUMBERS
# If the phone number is less than 10 digits, assume that it is a bad number
# If the phone number is 10 digits, assume that it is good
# If the phone number is 11 digits and the first number is 1, trim the 1 and use the remaining 10 digits
# If the phone number is 11 digits and the first number is not 1, then it is a bad number
# If the phone number is more than 11 digits, assume that it is a bad number

# require 'csv'
# require 'google/apis/civicinfo_v2'
# require 'erb'

# def clean_zipcode(zipcode)
#   zipcode.to_s.rjust(5,"0")[0..4]
# end

# def clean_phone_number(phone_number)
#     cleaned_phone_number = phone_number.gsub(/[^\d]/, '')

#     if cleaned_phone_number.length == 10
#         cleaned_phone_number
#     elsif cleaned_phone_number.length == 11 && cleaned_phone_number[0] == "1"
#         cleaned_phone_number[1..10]
#     else
#         'bad_number'
#     end
# end

# def legislators_by_zipcode(zip)
#   civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
#   civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

#   begin
#     civic_info.representative_info_by_address(
#       address: zip,
#       levels: 'country',
#       roles: ['legislatorUpperBody', 'legislatorLowerBody']
#     ).officials
#   rescue
#     'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
#   end
# end

# def save_thank_you_letter(id,form_letter)
#   Dir.mkdir('output') unless Dir.exist?('output')

#   filename = "output/thanks_#{id}.html"

#   File.open(filename, 'w') do |file|
#     file.puts form_letter
#   end
# end

# puts 'EventManager initialized.'

# contents = CSV.open(
#   '../event_attendees.csv',
#   headers: true,
#   header_converters: :symbol
# )

# template_letter = File.read('../form_letter.erb')
# erb_template = ERB.new template_letter

# contents.each do |row|
#   id = row[0]
#   name = row[:first_name]
#   zipcode = clean_zipcode(row[:zipcode])
#   legislators = legislators_by_zipcode(zipcode)
#   phone = clean_phone_number(row[:homephone])

#   form_letter = erb_template.result(binding)

#   save_thank_you_letter(id,form_letter)

#   puts "#{name} #{zipcode} #{phone}"
# end

# ASSIGNMENT: TIME TARGETING
# Using the registration date and time we want to find out what the peak registration hours are.
# Ruby has Date and Time classes that will be very useful for this task.
# For a quick overview, check out this Ruby Guides article.
# Explore the documentation to become familiar with the available methods, especially #strptime, #strftime, and #hour.

# require 'csv'
# require 'google/apis/civicinfo_v2'
# require 'erb'
# require 'time'

# def clean_zipcode(zipcode)
#   zipcode.to_s.rjust(5,"0")[0..4]
# end

# def clean_phone_number(phone_number)
#     cleaned_phone_number = phone_number.gsub(/[^\d]/, '')

#     if cleaned_phone_number.length == 10
#         cleaned_phone_number
#     elsif cleaned_phone_number.length == 11 && cleaned_phone_number[0] == "1"
#         cleaned_phone_number[1..10]
#     else
#         'bad_number'
#     end
# end

# def legislators_by_zipcode(zip)
#   civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
#   civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

#   begin
#     civic_info.representative_info_by_address(
#       address: zip,
#       levels: 'country',
#       roles: ['legislatorUpperBody', 'legislatorLowerBody']
#     ).officials
#   rescue
#     'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
#   end
# end

# def save_thank_you_letter(id,form_letter)
#   Dir.mkdir('output') unless Dir.exist?('output')

#   filename = "output/thanks_#{id}.html"

#   File.open(filename, 'w') do |file|
#     file.puts form_letter
#   end
# end

# def time_of_the_day(reg_times)
#     time_objects = reg_times.split(',').map { |time_str| Time.strptime(time_str.strip, "%m/%d/%y %H:%M") }
#     hour_counts = Hash.new(0)
#     time_objects.each { |time| hour_counts[time.hour] += 1 }
#     peak_hour = hour_counts.key(hour_counts.values.max)
#     peak_hour
# end

# puts 'EventManager initialized.'

# contents = CSV.open(
#   '../event_attendees.csv',
#   headers: true,
#   header_converters: :symbol
# )

# template_letter = File.read('../form_letter.erb')
# erb_template = ERB.new template_letter

# hour_counts_all = Hash.new(0)

# contents.each do |row|
#   id = row[0]
#   name = row[:first_name]
#   zipcode = clean_zipcode(row[:zipcode])
#   legislators = legislators_by_zipcode(zipcode)
#   phone = clean_phone_number(row[:homephone])

#   #form_letter = erb_template.result(binding)
#   #save_thank_you_letter(id,form_letter)

#   time_of_day = time_of_the_day(row[:regdate])
#   hour_counts_all[time_of_day] += 1

#   #puts "#{name} #{zipcode} #{phone}"
# end

# overall_peak_hour = hour_counts_all.key(hour_counts_all.values.max)
# puts "The most frequent hour of the day is #{overall_peak_hour}h."

# ASSIGNMENT: DAY OF THE WEEK TARGETING

require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'
require 'date'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone_number(phone_number)
    cleaned_phone_number = phone_number.gsub(/[^\d]/, '')

    if cleaned_phone_number.length == 10
        cleaned_phone_number
    elsif cleaned_phone_number.length == 11 && cleaned_phone_number[0] == "1"
        cleaned_phone_number[1..10]
    else
        'bad_number'
    end
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def time_of_the_day(reg_times)
    time_objects = reg_times.split(',').map { |time_str| Time.strptime(time_str.strip, "%m/%d/%y %H:%M") }
    hour_counts = Hash.new(0)
    time_objects.each { |time| hour_counts[time.hour] += 1 }
    peak_hour = hour_counts.key(hour_counts.values.max)
    peak_hour
end

puts 'EventManager initialized.'

contents = CSV.open(
  '../event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('../form_letter.erb')
erb_template = ERB.new template_letter

hour_counts_all = Hash.new(0)
day_counts_all = Hash.new(0)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)
  phone = clean_phone_number(row[:homephone])

  form_letter = erb_template.result(binding)
  save_thank_you_letter(id,form_letter)

  time_of_day = time_of_the_day(row[:regdate])
  hour_counts_all[time_of_day] += 1

  reg_date = Time.strptime(row[:regdate], "%m/%d/%y %H:%M")
  day_of_week = reg_date.wday
  day_counts_all[day_of_week] += 1

  puts "#{name} #{zipcode} #{phone}"
end

overall_peak_hour = hour_counts_all.key(hour_counts_all.values.max)
overall_peak_day = day_counts_all.key(day_counts_all.values.max)

puts "The most frequent hour of the day is #{overall_peak_hour}h."
puts "The day of the week with the most registrations is #{Date::DAYNAMES[overall_peak_day]}."