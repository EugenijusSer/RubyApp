require 'fileutils'
RSpec::Matchers.define(:be_identical_file_as) do |expected|
  match do |actual|
    FileUtils.identical?(actual, expected)
  end
end
