def interactive_menu
  students = []
  loop do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    selection = gets.chomp
    case selection
      when "1"
        students = input_students
      when "2"
        print_header
        print(students)
        print_footer(students)
      when "9"
        exit
      else
        puts "I don't know what you meant, try again"
    end
  end
end
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
    puts "What is their height in cm?"
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
  students.each_with_index do |student, index|
    if student[:name].length < 12
      puts ("#{index + 1}. #{student[:name]}, #{student[:cohort]} cohort, likes #{student[:hobby]}, born in #{student[:country]}, is #{student[:height]}cm tall").center(80)
    end
  end
end

def print_by_cohort(students)
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
  sorted_by_cohort.each do |cohort, students|
    puts "#{cohort} cohort:".center(80)
      students.each_with_index do |name, index|
        puts "#{index + 1}. #{name}".center(80)
      end
    end
end

def print_footer(students)
  if students.count == 1
    puts "Overall, we have #{students.count} great student".center(80)
  else
    puts "Overall, we have #{students.count} great students".center(80)
  end
end
students = input_students
print_header
print_by_cohort(students)
print_footer(students)
