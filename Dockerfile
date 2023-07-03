FROM ruby:3.2-alpine
ENV BUNDLER_VERSION=2.4
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
    python3 \
    tzdata \
    yarn
RUN gem install bundler -v ${BUNDLER_VERSION}

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY package.json yarn.lock ./
RUN yarn install --check-files
