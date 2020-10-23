FROM ruby:2.6.5-alpine

ENV BUNDLER_VERSION=2.1.4

RUN apk add --update --no-cache \
  binutils-gold \
  build-base \
  curl \
  file \
  g++ \
  gcc \
  git \
  less \
  libstdc++ \
  libffi-dev \
  libc-dev \ 
  linux-headers \
  libxml2-dev \
  libxslt-dev \
  libgcrypt-dev \
  make \
  netcat-openbsd \
  nodejs \
  openssl \
  pkgconfig \
  postgresql-dev \
  python \
  tzdata \
  yarn 

RUN gem install bundler -v 2.1.4

WORKDIR /app
# Add entire student fork (overwrites previously added package.json)
# ARG SUBMISSION_SUBFOLDER

# Copy over submission Gemfile & Gemfile.lock
# COPY ${SUBMISSION_SUBFOLDER}/Gemfile .
# COPY ${SUBMISSION_SUBFOLDER}/Gemfile.lock ./

# COPY Original Repo files
COPY ./Gemfile .
COPY ./Gemfile.lock .

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle check || bundle install

# COPY ${SUBMISSION_SUBFOLDER}/package.json .
# COPY ${SUBMISSION_SUBFOLDER}yarn.lock .

COPY ./package.json .
COPY ./yarn.lock .

RUN yarn upgrade webpack@^4.0.0 \
  yarn install

# ADD ${SUBMISSION_SUBFOLDER} /app
ADD . /app

RUN bin/rake assets:precompile

RUN chmod +x ./entrypoint.sh
RUN chmod +x ./test.sh

# If you want to run Rails in Docker
# ENTRYPOINT ["/app/entrypoint.sh"]

# IF you want to run tests
# ENTRYPOINT ["test.sh"]
CMD rails s -b 0.0.0.0 -p $PORT