require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user2)
    # @task = FactoryBot.create(:task)
    # @second_task = FactoryBot.create(:second_task)

    @task = FactoryBot.create(:task, user_id: @user.id )
    @task = FactoryBot.create(:second_task, user_id: @user2.id )
    
  end
  describe 'タスク一覧画面' do
    context 'ログインしていないユーザがタスク一覧画面に行った場合' do
      it 'トップページに戻されること' do
        visit tasks_path
        expect(current_path).to eq root_path
      end
    end
  end
  context '新規ユーザ登録した時' do
    it '自動的にログインする' do
      visit new_user_path
      fill_in 'user_name', with: 'testdesu'
      fill_in 'user_email', with: 'testdesu@aa.aa'
      fill_in 'user_password', with: 'testdesu'
      fill_in 'user_password_confirmation', with: 'testdesu'

      sleep 1 #findに書き換えたい
      click_on '登録する'

      expect(page).to have_content 'タスク一覧'
    end
  end
  context 'タスク一覧ページへ移動した時' do
    it '自分(カレントユーザ)のタスクのみが表示されていること' do
      visit new_session_path

      fill_in 'session_email', with: 'test8@aa.aa'
      fill_in 'session_password', with: 'testtesttest2'  
      click_on 'Log in'
      click_on 'タスク一覧'

      expect(page).to have_content '高'
      expect(page).not_to have_content '低'
    end
  end
  context '自分（カレントユーザ）以外のタスクの詳細ページに飛んだとき' do
    it '見れない。' do
      visit new_session_path

      fill_in 'session_email', with: 'test8@aa.aa'
      fill_in 'session_password', with: 'testtesttest2'  
      click_on 'Log in'
      visit task_path(7)
      
      expect(current_path).to eq tasks_path
      expect(page).to have_content 'あなたのタスクではありません。'
    end
  end
end

  #pageは画面上にあるかないか


