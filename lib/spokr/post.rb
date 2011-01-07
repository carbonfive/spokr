require 'httparty'

module Spokr

  class Post
    def self.all
      response = HTTParty.get('http://localhost:8983/spoke/api/find/.json')
      response.parsed_response
    end

    def self.create(path, params)
      response = HTTParty.post("http://localhost:8983/spoke/api/posts/#{path}.json", :body => params)
      response.parsed_response
    end

    def self.find(path, params)
      response = HTTParty.get("http://localhost:8983/spoke/api/find/#{path}.json", :query => params)
      response.parsed_response
    end
  end

end
