module Saucer
  class Client
    extend Memoist
    attr_accessor :user, :token, :api
    def initialize
      @user = Env.sauce_username
      @token = Env.sauce_access_key
      @api = Faraday.new "https://saucelabs.com/rest/v1/#{@user}" do |conn|
        conn.request :json
        conn.request :basic_auth, @user, @token

        conn.response :json, :content_type => /\bjson$/
        conn.adapter Faraday.default_adapter
      end
    end

    def jobs(count = 200)
      ids = job_ids(count)
      responses = ids.pmap do |id|
        slug = ['jobs', id].join('/')
        api.get(slug)
      end.flatten

      responses.map do |response|
        hsh = response.body
        normalize_hash_keys(hsh)
      end

    end
    memoize :jobs

    def normalize_hash_keys(hsh)
      Hash[hsh.map {|k, v| [k.gsub(/-/, '_'), v] }]
    end

    def job_ids(count = 200)
      args = get_iterations(count)
      responses = args.pmap do |args|
        response = api.get('jobs', args)
      end.flatten
      ids = extract_key(responses, 'id')
    end

    def extract_key(responses, key = 'id')
      job_ids = responses.map do |item|
        item.body.map { |i| i[key] }
      end.flatten.uniq
    end

    def get_iterations(count)
      count -= 100
      increment = 100
      steps = 0.step(count, increment).map { |a| a }
      limits = Array.new(steps.count, increment)
      args = steps.zip(limits)
      args.each_with_object([]) do |item, obj|
        skip, limit = item
        obj << {skip: skip, limit: limit}
      end
    end
  end
end
