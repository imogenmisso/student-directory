def input_students
  puts "Please enter the names of the students, followed by some personal information"
  puts "To finish, just hit return twice"
  #create an empty array
  students = []
  #get the first name
  name = gets.chomp
  while !name.empty? do
    puts "Favourite hobby"
      hobby = gets.chomp
    puts "Country of birth"
      country = gets.chomp
    puts "What is their height?"
      height = gets.chomp.to_s
    students << {name: name, cohort: :november, hobby: hobby, country: country, height: height}
    puts "Please enter another name"
    name = gets.chomp
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
    puts ("#{index + 1}. #{student[:name]}, #{student[:cohort]} cohort, likes #{student[:hobby]}, born in #{student[:country]}, is #{student[:height]}cm tall").center(80)
  end
end
def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(80)
end
#nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
