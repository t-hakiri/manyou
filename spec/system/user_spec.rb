require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user2)
    @task = FactoryBot.create(:task)
    @second_task = FactoryBot.create(:second_task)
  end
  describe 'タスク一覧画面' do
    context 'ログインしていないユーザがタスク一覧画面に行った場合' do
      it 'トップページに戻されること' do
        visit tasks_path
        expect(current_path).to eq root_path
      end
    end
  end
end