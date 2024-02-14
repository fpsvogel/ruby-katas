Dir.glob("#{ENV["KATA_NAME"]}/example*.rb").each do |file_name|
  require_relative file_name
end

require_relative "test_helper"
require_relative "#{ENV["KATA_NAME"]}/test"
