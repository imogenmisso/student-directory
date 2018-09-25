@students = []
def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_by_cohort
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "9"
      exit
    when "3"
      save_students
    when "4"
      load_students
    else
      puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students, followed by some personal information"
  puts "To finish, just hit return twice"
  students = []
  name = STDIN.gets.strip
  while !name.empty? do
    puts "Which cohort do they belong to?"
      cohort = STDIN.gets.strip
      if cohort.empty?
          cohort = :november
      end
      cohort = cohort.to_sym
    puts "Favourite hobby"
      hobby = STDIN.gets.strip
    puts "Country of birth"
      country = STDIN.gets.strip
    puts "What is their height in cm?"
      height = STDIN.gets.strip.to_s
    @students << {name: name, cohort: cohort, hobby: hobby, country: country, height: height}
    puts "Now we have #{@students.count} students"
    puts "Please enter another name"
    name = STDIN.gets.strip
  end
end

def print_header
  puts "The students of Villains Academy".center(80)
  puts "_____________".center(80)
end

def print_student_list
  count = 0
  until count == @students.count
    @students.each_with_index do |student, index|
      if student[:name].length < 12
        puts ("#{index + 1}. #{student[:name]}, #{student[:cohort]} cohort, likes #{student[:hobby]}, born in #{student[:country]}, is #{student[:height]}cm tall").center(80)
        count += 1
      end
    end
  end
end

def print_by_cohort
  sorted_by_cohort = {}
  @students.each do |students_under_consideration|
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

def print_footer
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student".center(80)
  else
    puts "Overall, we have #{@students.count} great students".center(80)
  end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_load_students
interactive_menu
