require_relative '../lib/story'
# Arrange
# clear savedata folder before doing this test
save_test = Story.new

# Act
save_test.save('testsave1')
save_test.save('testsave2')
save_test.save('testsave3')
save_test.list_of_saves

# Assert
if save_test.list_of_saves == 3
  puts 'test passed'
else
  puts 'test failed'
end
