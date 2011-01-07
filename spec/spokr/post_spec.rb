require 'spec_helper'

module Spokr 

  describe Post do

    describe '.all' do
      context 'given some existing posts' do
        before do
          2.times do
            Post.create('forums/create',
                        postClass: 'Forum', 
                        title: 'title', 
                        content: 'content')
          end 

          @response = Post.all
        end

        it 'returns all the posts in the hierarchy' do
          @response['posts'].should have(3).posts
        end

        it 'returns the total number of posts in the hierarchy' do
          @response['count'].should == 3
        end
      end
    end

    describe '.create' do
      context 'given a valid post' do
        before do
          @post = Post.create('forums/create',
                              postClass: 'Forum', 
                              title: 'title', 
                              content: 'content')
        end

        it 'creates a post' do
          @post.should be
          @post['postKey'].should be
          @post['title'].should == 'title'
          @post['content'].should == 'content'
        end
      end

      context 'given a path for the new post' do
        before do
          @post = Post.create 'forums/1', {}
        end

        it 'creates the post at the path' do
          @post['postKey'].should == '1'
        end
      end
    end

    describe '.find' do
      context 'given some post path' do
        before do
          Post.create 'forums/forum1', {}
          Post.create 'forums/forum1/topic1', {}
          Post.create 'forums/forum1/topic2', {}
          @post = Post.find 'forums/forum1', :postKeys => 'topic2'
        end

        it 'returns the post under that path' do
          @post['count'].should == 1
          @post['posts'].first['ancestry'].should == '/forums/forum1/'
        end
      end
    end

  end

end
