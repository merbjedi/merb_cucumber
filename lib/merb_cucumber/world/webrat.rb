# require 'webrat/rack/rack_session'
require File.join(File.dirname(__FILE__), 'base')

# We have to change the Webrat::Field implementation (Some Rails dependencies!)
module Webrat
  class Field
    
    def to_param
      return nil if disabled?
      value = @value.to_s.gsub('&', '%26')
      param_parser.query_parse("#{name}=#{value}")
    end
    
    def param_parser
      Merb::Request
    end
    
    def test_uploaded_file
      raise Merb::StatusCodes::NotImplemented.new
    end
    
  end
end

module Merb
  module Test
    module World
      # We are going to wait for the Webrat::RackSession to be included on the gem spec of webrat
      class Webrat < Webrat::Session
        include Base
        
        ## Begin RackSession implementations
        
        def response_body
          @response.body
        end

        def response_code
          @response.status
        end
        
        ## End of RackSession implementation
        
        attr_reader :response

        %w(get head post put delete).each do |verb|
          define_method(verb) do |*args| # (path, data, headers = nil)
            path, data, headers = *args
            all = (headers || {})
            all.merge!(:method => "#{verb.upcase}") unless all[:method] || all["REQUEST_METHOD"]
            
            unless data.empty?
              if verb == "post"
                all.merge!(:body_params => data)
              elsif verb == "get"
                all.merge!(:params => data)
              end
            end

            @response = request(path, all)
            
            class << @response
              def body
                super.to_s
              end
            end
            
            @response
          end
        end
      end
    end
  end
end

World do
  Merb::Test::World::Webrat.new
end
