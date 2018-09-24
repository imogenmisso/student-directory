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
  students.each_with_index do |student, index|
    if student[:name].length < 12
      puts ("#{index + 1}. #{student[:name]}, #{student[:cohort]} cohort, likes #{student[:hobby]}, born in #{student[:country]}, is #{student[:height]}cm tall").center(80)
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
#nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
