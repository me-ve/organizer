require 'json'

class Event
    def initialize(args)
        @type = args["type"]
        @name = args["name"]
        @time_start = args["time_start"]
        @time_end = args["time_end"]
        @supervisor = args["supervisor"]
        @notes = args["notes"]
    end
    def to_s
        "#{@name}\n(#{@type})\nTime: #{@time_start}-#{@time_end}\nSupervisor: #{@supervisor}\nNotes: #{@notes}\n"
    end
end

class Day
    def initialize(args)
        @name = args["name"]
        @events = Array.new()
        args["events"].each do |event|
            add_event(event)
        end
    end
    def add_event(event)
        @events.push(Event.new(event))
    end
    def to_s
        str = "#{@name}\n"
        @events.each do |event|
            str += "#{event}\n\n"
        end
        str
    end
end

class Plan
    def initialize(args)
        @title = args["title"]
        @description = args["description"]
        @created = args["created"]
        @modified = args["modified"]
        @days = Array.new()
        args["days"].each do |day|
            add_day(day)
        end
    end
    def add_day(args)
        @days.push(Day.new(args))
    end
    def to_s
        str = "#{@title}, #{@description}, #{@created}\n"
        @days.each do |day|
            str += "#{day}\n\n"
        end
        str
    end
end

plan = {}
puts "ORGANIZER"
while(true)
    print "org > "
    command = gets.chomp.downcase
    case command
    when "add", "insert"
        # TODO insert new events
        print "Day (number): "
        day = gets.chomp
        print "Name: "
        name = gets.chomp
        print "Type: "
        type = gets.chomp
        print "Time start (hh:mm): "
        time_start = gets.chomp
        print "Time end (hh:mm): "
        time_stop = gets.chomp
        print "Supervisor: "
        supervisor = gets.chomp
        print "Notes: "
        notes = gets.chomp
    when "edit"
        # TODO edit the plan
    when "exit", "quit"
        exit
    when "help"
        # TODO add help
    when "list", "ls"
        puts plan
    when "load"
        puts "Enter the filename path"
        filename = gets.chomp
        begin
            print "Loading file #{filename}... "
            file = File.read(filename)
            puts "Done."
            print "Getting plan from file #{filename}... "
            json = JSON.parse(file)
            plan = Plan.new(json)
            puts "Done."
            puts "Plan loaded."
        rescue
            puts "\nThe plan from file #{filename} could not have been loaded."
        end
    when "new"
        # TODO create new plan
    when "save"
        # TODO save the plan
    else
        puts "Bad command"
    end
end