require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#create' do

	subject { post :create, params: params }

    context 'with valid params' do
      let(:params) do
      	{ email: 'email@e.mail', password: '123456', 
      		password_confirmation: '123456'}
      end

      it 'should create new user' do
      	expect { subject }.to change {User.count}.from(0).to(1)
      	expect(response.code).to eq '201'
      end
    end

	context 'with valid params' do
      let(:params) do
      	{ email: 'not_email', password: 'sfsf', 
      		password_confirmation: '123456123'}
      end

      it 'should create new user' do
      	expect { subject }.not_to change {User.count}
      	expect(response.code).to eq '200'
      end
    end
  end
end