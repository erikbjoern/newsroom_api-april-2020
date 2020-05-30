# frozen_string_literal: true

RSpec.describe 'Api::Admin::Articles :index', type: :request do
  let!(:article) { create(:article, :with_image, published: false) }

  let(:editor) { create(:user, role: 'editor') }
  let(:editors_credentials) { editor.create_new_auth_token }
  let(:editors_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(editors_credentials) }

  let(:journalist) { create(:user, role: 'journalist') }
  let(:journalist_credentials) { journalist.create_new_auth_token }
  let(:journalist_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(journalist_credentials) }

  describe 'GET /api/admin/articles/:id' do
    before do
      get "/api/admin/articles/#{article.id}", headers: editors_headers
    end

    it 'has a 200 response' do
      expect(response).to have_http_status 200
    end

    describe 'response has keys' do
      it ':title' do
        expect(response_json['article']).to have_key 'title'
      end

      it ':body' do
        expect(response_json['article']).to have_key 'body'
      end

      it ':created_at' do
        expect(response_json['article']).to have_key 'created_at'
      end

      it ':image' do
        expect(response_json['article']).to have_key 'image'
      end
    end
  end

  describe 'GET /api/admin/articles/:id to non-existing id' do
    before do
      get '/api/admin/articles/1000002'
    end

    it 'has a 404 response' do
      expect(response).to have_http_status 404
    end

    it 'responds with error message' do
      expect(response_json['message']).to eq 'Article with id 1000002 could not be found.'
    end
  end

  describe 'GET /api/admin/articles/:id unauthorized when journalist' do
    before do
      get "/api/admin/articles/#{article.id}", headers: journalist_headers
    end

    it 'has a 401 response' do
      expect(response).to have_http_status 401
    end

    it 'journalist cannot see unpublished articles' do
      expect(response_json['message']).to eq 'You are not authorized'
    end
  end

  describe 'GET /api/admin/articles unauthorized when no-login' do
    before do
      get "/api/admin/articles/#{article.id}"
    end

    it 'has a 401 response' do
      expect(response).to have_http_status 401
    end

    it 'visitor cannot see unpublished articles' do
      expect(response_json['errors'][0]).to eq 'You need to sign in before continuing.'
    end
  end
end