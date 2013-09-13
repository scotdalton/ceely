To run on a Mac

1. git clone https://github.com/scotdalton/ceely.git
2. cd ceely
3. rvm use jruby
4. bundle install
5. export JAVA_OPTS=-XstartOnFirstThread
6. bundle exec ruby-shoes assignments/assignmentX.rb

Hope to make this a vagrant box (prolly Ubuntu) and distribute it that way.
