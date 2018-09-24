def input_students
  puts "Please enter the names of the students, followed by some personal information"
  puts "To finish, just hit return twice"
  #create an empty array
  students = []
  #get the first name
  name = gets.strip
  while !name.empty? do
    puts "Which cohort do they belong to?"
      cohort = gets.strip
      if cohort.empty?
          cohort = :november
      end
      cohort = cohort.to_sym
    puts "Favourite hobby"
      hobby = gets.strip
    puts "Country of birth"
      country = gets.strip
    puts "What is their height?"
      height = gets.strip.to_s
    students << {name: name, cohort: cohort, hobby: hobby, country: country, height: height}
    puts "Please enter another name"
    name = gets.strip
  end
  #return the array of students
  students
end
def print_header
  puts "The students of Villains Academy".center(80)
  puts "_____________".center(80)
end
def print(students)
  sorted_by_cohort = {}
  students.each do |students_under_consideration|
    cohort = students_under_consideration[:cohort]
    name = students_under_consideration[:name]
    if sorted_by_cohort[cohort] == nil
      sorted_by_cohort[cohort] = [name]
    else
      sorted_by_cohort[cohort].push(name)
    end
  end
  sorted_by_cohort.each do |key, value|
    puts (key.to_s + ": " + value.to_s).center(80)
  end
end
def print_footer(students)
  if students.count == 1
    puts "Overall, we have #{students.count} great student".center(80)
  else
    puts "Overall, we have #{students.count} great students".center(80)
  end
end
#nothing happens until we call the methods
students = input_students
print_header
print_revised(students)
print_footer(students)
