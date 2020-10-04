require_relative '../lib/story'
# Arrange
save_test = Story.new

# Act
# for more test cases, change testname to different names
save_test.save('testname')
savelist = []

# Assert
Dir.foreach('../Mark Huang_T1A3/savedata') do |item|
  savelist << item
end
savelist.select! do |item|
  item =~ /.yml\b/
  item =~ /\btestname/
end

if savelist != []
  puts 'test passed.'
else
  puts 'test failed.'
end
