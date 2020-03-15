require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"

  files = if ENV['QUIZ_NUMBER']
    ENV['QUIZ_NUMBER'].to_i.times.map { |num| "test/#{num.to_s.rjust(2, '0')}_*/test_*.rb" }
  else
    "test/**/test_*.rb"
  end

  t.test_files = FileList[*files]
end

task :default => :test
