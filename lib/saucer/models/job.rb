module Saucer
  module Coercions
    NilToString = lambda do |value|
      String(value)
    end

    EpochToDateTime = lambda do |value|
      Time.at(value.to_i).to_datetime
    end
  end

  class Job
    include Virtus.model
    include Coercions

    attribute :browser_short_version   , String, coercer: NilToString
    attribute :video_url               , String, coercer: NilToString
    attribute :creation_time           , String, coercer: EpochToDateTime
    attribute :custom_data             , String, coercer: NilToString
    attribute :browser_version         , String, coercer: NilToString
    attribute :owner                   , String, coercer: NilToString
    attribute :id                      , String, coercer: NilToString
    attribute :log_url                 , String, coercer: NilToString
    attribute :build                   , String, coercer: NilToString
    attribute :passed                  , String, coercer: NilToString
    attribute :public                  , String, coercer: NilToString
    attribute :status                  , String, coercer: NilToString
    attribute :tags                    , Array
    attribute :start_time              , String, coercer: EpochToDateTime
    attribute :proxied                 , Boolean
    attribute :commands_not_successful , String, coercer: NilToString
    attribute :name                    , String, coercer: NilToString
    attribute :manual                  , Boolean
    attribute :end_time                , String, coercer: EpochToDateTime
    attribute :error                   , String, coercer: NilToString
    attribute :os                      , String, coercer: NilToString
    attribute :breakpointed            , String, coercer: NilToString
    attribute :browser                 , String, coercer: NilToString

    def passed?
      !! error.empty?
    end

    def error?
      ! passsed?
    end
  end

end
