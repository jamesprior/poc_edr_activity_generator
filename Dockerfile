FROM ruby:2.7-buster

# Cheat so that uname exists in the same location on OS X and Linux
RUN cp /bin/uname /usr/bin/uname

COPY . .
RUN bundle install