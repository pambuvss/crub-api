require 'rails_helper'

RSpec.describe FurnitureItemsController, type: :controller do
  describe '#index' do
    let!(:furniture_1) { create :furniture_item, shop: shop }
    let!(:furniture_2) { create :furniture_item }
    let!(:shop) { create :shop }
    let!(:seller) { create :user, role: :seller, shop: shop }

    let(:params) do
      {
        token: active_user.authentication_token
      }
    end

    subject { get :index, params: params }

    context 'when active user is a seller' do
      let(:active_user) { seller }
      let(:expected_response_body) { [furniture_1.as_json].as_json }

      it 'should return only his furniture' do
        subject
        expect(response.code).to eq '200'
        expect(JSON.parse response.body).to eq expected_response_body  
      end
    end

    context 'when active user is not seller' do
      let(:active_user) { create :user }
      let(:expected_response_body) { [furniture_1.as_json, furniture_2.as_json].as_json }

      it 'should return all furniture' do
        subject
        expect(response.code).to eq '200'
        expect(JSON.parse response.body).to eq expected_response_body  
      end
    end
  end

  describe '#create' do
    let(:params) do
      {
      token: active_user.authentication_token,
      furniture_item: {
        name: 'name',
        kind: 1,
        description: 'desc',
        length: 10,
        width: 15,
        price: 1500
      }
      }
    end

    subject { post :create, params: params }

    context 'when active user is seller' do
      let!(:shop) { create :shop }
      let(:active_user) { create :user, role: :seller, shop: shop }

      it 'should create new furniture' do
        expect { subject }.to change { FurnitureItem.count }.by(1) 
        expect(response.code).to eq '201'
      end
    end

    context 'when active user is not seller' do
      let(:active_user) { create :user }
      
      it 'should return 401' do
        expect { subject }.not_to change { FurnitureItem.count } 
        expect(response.code).to eq '401'
      end
    end
  end  
end