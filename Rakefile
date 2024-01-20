require "rake"
require "rake/testtask"

# CAUTION: This file is brittle. The last set of tasks at the bottom (concise
# example.rb) is a bit of a hack. It must stay at the bottom, and it must check
# that ARGV[0] does not contain any of the other rake tasks. So if a rake task
# is added, it must also be added to that check. If several other rake tasks are
# added, consider removing the concise tasks which that hack makes possible.

# Run tests against a kata's example solution (example.rb).
# Example:
#   rake test gilded-rose
Rake::TestTask.new(:test) do |t|
  ENV["KATA_NAME"] = ARGV[1]
  t.test_files = ["test_kata_example.rb"]
end

# Run tests against a kata's starting code (start.rb instead of example.rb).
# Example:
#   rake test:start gilded-rose
namespace :test do
  Rake::TestTask.new(:start) do |t|
    ENV["KATA_NAME"] = ARGV[1]
    t.test_files = ["test_kata_start.rb"]
  end
end

# More concise alternatives to the above.

# More consisely run tests against a kata's starting code (start.rb).
# Example:
#   rake start gilded-rose
Rake::TestTask.new(:start) do |t|
  ENV["KATA_NAME"] = ARGV[1]
  t.test_files = ["test_kata_start.rb"]
end

# More concisely run tests against a kata's example solution (example.rb).
# Example:
#   rake gilded-rose
Dir["*"].select { File.directory? _1 }.each do |dir|
  Rake::TestTask.new(dir) do |t|
    unless ["test", "test:start", "start"].include?(ARGV[0])
      ENV["KATA_NAME"] = ARGV[0]
      t.test_files = ["test_kata_example.rb"]
    end
  end
end
