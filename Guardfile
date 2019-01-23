# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

guard :minitest,  spring: "bin/rails test", all_on_start: false  do
  watch('test/test_helper.rb')  { "test" }
  #watch(%r{test/factories/(.+)\.rb})  { "test" }

  # Rails 4
  watch(%r{^app/(.+)\.rb})                               { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/application_controller\.rb}) { 'test/controllers' }
  watch(%r{^app/controllers/(.+)_controller\.rb})        { |m| "test/controllers/#{m[1]}_test.rb" }
  watch(%r{^app/views/(.+)_mailer/.+})                   { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
  watch(%r{^app/models/(.+)\.rb})                        { |m| "test/models/#{m[1]}_test.rb" }
  watch(%r{^app/helpers/(.+)\.rb})                       { |m| "test/helpers/#{m[1]}_test.rb" }
  watch(%r{^app/lib/(.+)\.rb})                           { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^test/factories/(.+)\.rb})                    { |m| "test/models/#{m[1].chomp('s')}_test.rb" }
  watch(%r{^test/.+_test\.rb})
  watch(%r{^test/test_helper\.rb}) { 'test' }

end
