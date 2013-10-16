# Ref: http://stackoverflow.com/questions/14631910/logging-in-delayed-job

# Log delayed jobs
Delayed::Worker.logger = Logger.new(File.join(Rails.root, 'log', 'delayed.log'))
